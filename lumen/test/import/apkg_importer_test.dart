import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lumen/data/database.dart';
import 'package:lumen/data/media_store.dart';
import 'package:lumen/import/apkg_importer.dart';
import 'package:path/path.dart' as p;

void main() {
  test('imports the fixture Basic package', () async {
    final fixture = File(
      p.normalize(
        p.join(Directory.current.path, '..', '..', 'fixtures', 'lumen_basic.apkg'),
      ),
    );
    if (!fixture.existsSync()) {
      final gen = File(
        p.normalize(
          p.join(Directory.current.path, '..', '..', 'fixtures', 'generate_basic_apkg.py'),
        ),
      );
      await Process.run('python3', [gen.path]);
    }
    expect(fixture.existsSync(), isTrue);

    final db = LumenDatabase.memory();
    addTearDown(db.close);
    final mediaDir = await Directory.systemTemp.createTemp('lumen_media_');
    addTearDown(() => mediaDir.deleteSync(recursive: true));

    final importer = ApkgImporter(
      db: db,
      mediaStore: MediaStore(root: mediaDir),
    );
    final report = await importer.importFile(fixture);

    expect(report.notes, 1);
    expect(report.cards, 1);
    expect(report.decks, greaterThanOrEqualTo(1));
    expect(report.rootDeckName.contains('Lumen Sample'), isTrue);

    final notes = await db.select(db.notes).get();
    expect(notes.length, greaterThanOrEqualTo(1));
    final fields = await db.select(db.noteFields).get();
    expect(fields.any((f) => f.value.contains('Paris')), isTrue);
  });
}
