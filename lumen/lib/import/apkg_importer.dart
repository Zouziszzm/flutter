import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:drift/drift.dart';
import 'package:es_compression/zstd.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart' as raw;
import '../core/html_text.dart';
import '../data/database.dart';
import '../data/media_store.dart';

class ImportReport {
  const ImportReport({
    required this.notes,
    required this.cards,
    required this.media,
    required this.decks,
    required this.warnings,
    required this.rootDeckName,
  });

  final int notes;
  final int cards;
  final int media;
  final int decks;
  final List<String> warnings;
  final String rootDeckName;
}

class ApkgImporter {
  ApkgImporter({
    required this.db,
    required this.mediaStore,
  });

  final LumenDatabase db;
  final MediaStore mediaStore;

  Future<ImportReport> importFile(File package) async {
    final tmp = await Directory.systemTemp.createTemp('lumen_apkg_');
    try {
      _unzipPackage(package, tmp);
      return await _importExtracted(tmp);
    } finally {
      if (tmp.existsSync()) {
        tmp.deleteSync(recursive: true);
      }
    }
  }

  void _unzipPackage(File package, Directory dest) {
    final archive = ZipDecoder().decodeBytes(package.readAsBytesSync());
    for (final file in archive) {
      final name = file.name.replaceAll('\\', '/');
      if (name.contains('..')) continue;
      final outPath = p.join(dest.path, name);
      if (!p.isWithin(dest.path, outPath) && outPath != dest.path) continue;
      if (file.isFile) {
        File(outPath)
          ..parent.createSync(recursive: true)
          ..writeAsBytesSync(file.content);
      } else {
        Directory(outPath).createSync(recursive: true);
      }
    }
  }

  Future<ImportReport> _importExtracted(Directory tmp) async {
    final warnings = <String>[];
    final dbFile = await _resolveCollection(tmp, warnings);
    final anki = raw.sqlite3.open(dbFile.path, mode: raw.OpenMode.readOnly);
    try {
      final tables = anki
          .select("SELECT name FROM sqlite_master WHERE type='table'")
          .map((r) => r['name'] as String)
          .toSet();

      final models = _readModels(anki, tables, warnings);
      final ankiDecks = _readDecks(anki, tables, warnings);
      final mediaMap = await _readMediaMap(tmp, warnings);
      final filenameToPath = <String, String>{};

      for (final entry in mediaMap.entries) {
        final src = File(p.join(tmp.path, entry.key));
        if (!src.existsSync()) {
          warnings.add('Missing media file ${entry.key} (${entry.value})');
          continue;
        }
        final dest = await mediaStore.saveFile(entry.value, src);
        filenameToPath[entry.value] = dest;
        await db.into(db.media).insert(
              MediaCompanion.insert(filename: entry.value, path: dest),
            );
      }

      final deckIdMap = <int, int>{};
      var importedDecks = 0;
      final sortedDecks = ankiDecks.values.toList()
        ..sort((a, b) => a.fullName.split('::').length.compareTo(b.fullName.split('::').length));

      for (final deck in sortedDecks) {
        if (deck.filtered) {
          warnings.add('Skipped filtered deck "${deck.fullName}"');
          continue;
        }
        if (deck.fullName == 'Default' && ankiDecks.length > 1) {
          continue;
        }
        final parts = deck.fullName.split('::');
        final name = parts.last;
        int? parentId;
        if (parts.length > 1) {
          final parentName = parts.sublist(0, parts.length - 1).join('::');
          final parent = ankiDecks.values.cast<_AnkiDeck?>().firstWhere(
                (d) => d!.fullName == parentName,
                orElse: () => null,
              );
          if (parent != null) parentId = deckIdMap[parent.id];
        }
        final id = await db.into(db.decks).insert(
              DecksCompanion.insert(
                parentId: Value(parentId),
                name: name,
                fullName: deck.fullName,
                ankiDeckId: Value(deck.id),
                isFiltered: Value(deck.filtered),
              ),
            );
        deckIdMap[deck.id] = id;
        importedDecks++;
      }

      if (deckIdMap.isEmpty) {
        final id = await db.into(db.decks).insert(
              DecksCompanion.insert(name: 'Imported', fullName: 'Imported'),
            );
        deckIdMap[1] = id;
        importedDecks = 1;
      }

      final typeIdMap = <int, int>{};
      final fieldIdMap = <int, Map<int, int>>{};
      final templateIdMap = <int, Map<int, int>>{};

      for (final model in models.values) {
        final typeId = await db.into(db.noteTypes).insert(
              NoteTypesCompanion.insert(
                name: model.name,
                ankiModelId: Value(model.id),
                css: Value(model.css),
                isCloze: Value(model.isCloze),
              ),
            );
        typeIdMap[model.id] = typeId;
        fieldIdMap[model.id] = {};
        templateIdMap[model.id] = {};
        for (final field in model.fields) {
          final fid = await db.into(db.fields).insert(
                FieldsCompanion.insert(
                  noteTypeId: typeId,
                  name: field.name,
                  ordinal: field.ord,
                ),
              );
          fieldIdMap[model.id]![field.ord] = fid;
        }
        for (final tmpl in model.templates) {
          final tid = await db.into(db.templates).insert(
                TemplatesCompanion.insert(
                  noteTypeId: typeId,
                  name: tmpl.name,
                  frontHtml: tmpl.qfmt,
                  backHtml: tmpl.afmt,
                  ordinal: tmpl.ord,
                ),
              );
          templateIdMap[model.id]![tmpl.ord] = tid;
        }
      }

      final notes = anki.select('SELECT id, mid, tags, flds FROM notes');
      var noteCount = 0;
      final noteIdMap = <int, int>{};

      for (final row in notes) {
        final ankiNoteId = row['id'] as int;
        final mid = row['mid'] as int;
        final typeId = typeIdMap[mid];
        if (typeId == null) {
          warnings.add('Note $ankiNoteId has unknown note type $mid');
          continue;
        }
        final tags = (row['tags'] as String? ?? '').trim();
        var flds = row['flds'] as String? ?? '';
        if (filenameToPath.isNotEmpty) {
          flds = rewriteMediaSrc(flds, filenameToPath);
        }
        final values = flds.split('\u001f');
        final lumenNoteId = await db.into(db.notes).insert(
              NotesCompanion.insert(
                noteTypeId: typeId,
                ankiNoteId: Value(ankiNoteId),
                tags: Value(tags),
              ),
            );
        noteIdMap[ankiNoteId] = lumenNoteId;
        final fields = fieldIdMap[mid] ?? {};
        for (final e in fields.entries) {
          final value = e.key < values.length ? values[e.key] : '';
          await db.into(db.noteFields).insert(
                NoteFieldsCompanion.insert(
                  noteId: lumenNoteId,
                  fieldId: e.value,
                  value: value,
                ),
              );
        }
        noteCount++;
      }

      final now = DateTime.now().toUtc();
      final cards = anki.select('SELECT id, nid, did, ord, queue FROM cards');
      var cardCount = 0;
      for (final row in cards) {
        final nid = row['nid'] as int;
        final lumenNoteId = noteIdMap[nid];
        if (lumenNoteId == null) continue;
        final did = row['did'] as int;
        final deckId = deckIdMap[did] ?? deckIdMap.values.first;
        final ord = row['ord'] as int;
        final mid = _noteMid(anki, nid);
        final templateId = templateIdMap[mid]?[ord] ??
            templateIdMap[mid]?.values.firstOrNull;
        if (templateId == null) {
          warnings.add('Card ${row['id']} missing template');
          continue;
        }
        final queue = row['queue'] as int? ?? 0;
        await db.into(db.cards).insert(
              CardsCompanion.insert(
                noteId: lumenNoteId,
                deckId: deckId,
                templateId: templateId,
                ankiCardId: Value(row['id'] as int),
                ordinal: Value(ord),
                due: now,
                suspended: Value(queue == -1),
              ),
            );
        cardCount++;
      }

      final rootName = sortedDecks
              .where((d) => !d.filtered && d.fullName != 'Default')
              .map((d) => d.fullName.split('::').first)
              .toSet()
              .join(', ');

      return ImportReport(
        notes: noteCount,
        cards: cardCount,
        media: filenameToPath.length,
        decks: importedDecks,
        warnings: warnings,
        rootDeckName: rootName.isEmpty ? 'Imported' : rootName,
      );
    } finally {
      anki.dispose();
    }
  }

  int _noteMid(raw.Database anki, int nid) {
    final rows = anki.select('SELECT mid FROM notes WHERE id = ?', [nid]);
    return rows.first['mid'] as int;
  }

  Future<File> _resolveCollection(Directory tmp, List<String> warnings) async {
    final anki21b = File(p.join(tmp.path, 'collection.anki21b'));
    final anki21 = File(p.join(tmp.path, 'collection.anki21'));
    final anki2 = File(p.join(tmp.path, 'collection.anki2'));

    if (anki21b.existsSync()) {
      try {
        final decoded = zstd.decode(anki21b.readAsBytesSync());
        final out = File(p.join(tmp.path, 'collection.decoded.sqlite'));
        out.writeAsBytesSync(decoded);
        return out;
      } catch (e) {
        warnings.add(
          'Could not read latest Anki package (anki21b). Re-export from Anki with “Support older Anki versions”. ($e)',
        );
      }
    }
    if (anki21.existsSync()) return anki21;
    if (anki2.existsSync()) return anki2;
    throw const FormatException('Not a valid Anki package (no collection database).');
  }

  Map<int, _AnkiModel> _readModels(
    raw.Database anki,
    Set<String> tables,
    List<String> warnings,
  ) {
    if (tables.contains('col')) {
      final rows = anki.select('SELECT models FROM col');
      if (rows.isNotEmpty) {
        final rawJson = rows.first['models'];
        if (rawJson is String && rawJson.trim().startsWith('{')) {
          final map = jsonDecode(rawJson) as Map<String, dynamic>;
          if (map.isNotEmpty) {
            return {
              for (final e in map.entries)
                int.parse(e.key): _AnkiModel.fromJson(e.value as Map<String, dynamic>),
            };
          }
        }
      }
    }

    if (tables.contains('notetypes') && tables.contains('fields')) {
      return _readModelsFromTables(anki, tables, warnings);
    }

    warnings.add('Could not read note types; fields will be numbered.');
    return {};
  }

  Map<int, _AnkiModel> _readModelsFromTables(
    raw.Database anki,
    Set<String> tables,
    List<String> warnings,
  ) {
    final models = <int, _AnkiModel>{};
    final types = anki.select('SELECT id, name FROM notetypes');
    for (final t in types) {
      final id = t['id'] as int;
      final fields = anki.select(
        'SELECT ord, name FROM fields WHERE ntid = ? ORDER BY ord',
        [id],
      );
      final tmpls = tables.contains('templates')
          ? anki.select(
              'SELECT ord, name FROM templates WHERE ntid = ? ORDER BY ord',
              [id],
            )
          : <raw.Row>[];
      models[id] = _AnkiModel(
        id: id,
        name: t['name'] as String? ?? 'Note type',
        isCloze: false,
        css: '',
        fields: [
          for (final f in fields)
            _AnkiField(name: f['name'] as String? ?? 'Field', ord: f['ord'] as int),
        ],
        templates: [
          for (final tmpl in tmpls)
            _AnkiTemplate(
              name: tmpl['name'] as String? ?? 'Card',
              ord: tmpl['ord'] as int,
              qfmt: '{{Front}}',
              afmt: '{{Back}}',
            ),
        ],
      );
    }
    if (models.isEmpty) {
      warnings.add('Note-type tables were empty.');
    }
    return models;
  }

  Map<int, _AnkiDeck> _readDecks(
    raw.Database anki,
    Set<String> tables,
    List<String> warnings,
  ) {
    if (tables.contains('col')) {
      final rows = anki.select('SELECT decks FROM col');
      if (rows.isNotEmpty) {
        final rawJson = rows.first['decks'];
        if (rawJson is String && rawJson.trim().startsWith('{')) {
          final map = jsonDecode(rawJson) as Map<String, dynamic>;
          if (map.isNotEmpty) {
            return {
              for (final e in map.entries)
                int.parse(e.key): _AnkiDeck.fromJson(e.value as Map<String, dynamic>),
            };
          }
        }
      }
    }
    if (tables.contains('decks')) {
      final rows = anki.select('SELECT id, name FROM decks');
      return {
        for (final r in rows)
          r['id'] as int: _AnkiDeck(
            id: r['id'] as int,
            fullName: r['name'] as String? ?? 'Deck',
            filtered: false,
          ),
      };
    }
    warnings.add('No decks found; using a single Imported deck.');
    return {};
  }

  Future<Map<String, String>> _readMediaMap(
    Directory tmp,
    List<String> warnings,
  ) async {
    final file = File(p.join(tmp.path, 'media'));
    if (!file.existsSync()) return {};
    final bytes = file.readAsBytesSync();
    try {
      final decoded = utf8.decode(bytes);
      if (decoded.trim().startsWith('{')) {
        final map = jsonDecode(decoded) as Map<String, dynamic>;
        // Anki stores { "0": "foo.jpg" } — index to filename.
        return {
          for (final e in map.entries) e.key: e.value.toString(),
        };
      }
    } catch (_) {
      warnings.add('Media map is not JSON (newer Protobuf format). Media may be skipped.');
    }
    // Fallback: numbered files in the zip with unknown names.
    final numbered = <String, String>{};
    for (final entity in tmp.listSync()) {
      final name = p.basename(entity.path);
      if (RegExp(r'^\d+$').hasMatch(name) && entity is File) {
        numbered[name] = 'media_$name';
      }
    }
    return numbered;
  }
}

class _AnkiModel {
  _AnkiModel({
    required this.id,
    required this.name,
    required this.isCloze,
    required this.css,
    required this.fields,
    required this.templates,
  });

  factory _AnkiModel.fromJson(Map<String, dynamic> json) {
    final fields = <_AnkiField>[];
    final rawFields = json['flds'] as List<dynamic>? ?? [];
    for (final f in rawFields) {
      final m = f as Map<String, dynamic>;
      fields.add(
        _AnkiField(
          name: m['name'] as String? ?? 'Field',
          ord: m['ord'] as int? ?? fields.length,
        ),
      );
    }
    final templates = <_AnkiTemplate>[];
    final rawTmpls = json['tmpls'] as List<dynamic>? ?? [];
    for (final t in rawTmpls) {
      final m = t as Map<String, dynamic>;
      templates.add(
        _AnkiTemplate(
          name: m['name'] as String? ?? 'Card',
          ord: m['ord'] as int? ?? templates.length,
          qfmt: m['qfmt'] as String? ?? '{{Front}}',
          afmt: m['afmt'] as String? ?? '{{Back}}',
        ),
      );
    }
    return _AnkiModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? 'Note type',
      isCloze: json['type'] == 1,
      css: json['css'] as String? ?? '',
      fields: fields,
      templates: templates,
    );
  }

  final int id;
  final String name;
  final bool isCloze;
  final String css;
  final List<_AnkiField> fields;
  final List<_AnkiTemplate> templates;
}

class _AnkiField {
  _AnkiField({required this.name, required this.ord});
  final String name;
  final int ord;
}

class _AnkiTemplate {
  _AnkiTemplate({
    required this.name,
    required this.ord,
    required this.qfmt,
    required this.afmt,
  });
  final String name;
  final int ord;
  final String qfmt;
  final String afmt;
}

class _AnkiDeck {
  _AnkiDeck({
    required this.id,
    required this.fullName,
    required this.filtered,
  });

  factory _AnkiDeck.fromJson(Map<String, dynamic> json) {
    return _AnkiDeck(
      id: (json['id'] as num?)?.toInt() ?? 0,
      fullName: json['name'] as String? ?? 'Deck',
      filtered: json['dyn'] == 1,
    );
  }

  final int id;
  final String fullName;
  final bool filtered;
}
