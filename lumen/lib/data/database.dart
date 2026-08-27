import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Decks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer().nullable()();
  TextColumn get name => text()();
  TextColumn get fullName => text()();
  IntColumn get ankiDeckId => integer().nullable()();
  IntColumn get newPerDay => integer().withDefault(const Constant(20))();
  IntColumn get revPerDay => integer().withDefault(const Constant(200))();
  BoolColumn get isFiltered => boolean().withDefault(const Constant(false))();
}

class NoteTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get ankiModelId => integer().nullable()();
  TextColumn get css => text().withDefault(const Constant(''))();
  BoolColumn get isCloze => boolean().withDefault(const Constant(false))();
}

class Fields extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get noteTypeId => integer()();
  TextColumn get name => text()();
  IntColumn get ordinal => integer()();
}

class Templates extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get noteTypeId => integer()();
  TextColumn get name => text()();
  TextColumn get frontHtml => text()();
  TextColumn get backHtml => text()();
  IntColumn get ordinal => integer()();
}

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get noteTypeId => integer()();
  IntColumn get ankiNoteId => integer().nullable()();
  TextColumn get tags => text().withDefault(const Constant(''))();
  DateTimeColumn get modifiedAt => dateTime().withDefault(currentDateAndTime)();
}

class NoteFields extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get noteId => integer()();
  IntColumn get fieldId => integer()();
  TextColumn get value => text()();
}

class Cards extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get noteId => integer()();
  IntColumn get deckId => integer()();
  IntColumn get templateId => integer()();
  IntColumn get ankiCardId => integer().nullable()();
  IntColumn get ordinal => integer().withDefault(const Constant(0))();
  TextColumn get state => text().withDefault(const Constant('new'))();
  DateTimeColumn get due => dateTime()();
  RealColumn get stability => real().nullable()();
  RealColumn get difficulty => real().nullable()();
  IntColumn get reps => integer().withDefault(const Constant(0))();
  IntColumn get lapses => integer().withDefault(const Constant(0))();
  IntColumn get scheduledDays => integer().withDefault(const Constant(0))();
  IntColumn get learningSteps => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastReview => dateTime().nullable()();
  DateTimeColumn get firstReviewedAt => dateTime().nullable()();
  BoolColumn get suspended => boolean().withDefault(const Constant(false))();
}

class Reviews extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get cardId => integer()();
  DateTimeColumn get ratedAt => dateTime()();
  IntColumn get rating => integer()();
  IntColumn get elapsedDays => integer().withDefault(const Constant(0))();
  RealColumn get stabilityAfter => real().nullable()();
  IntColumn get durationMs => integer().withDefault(const Constant(0))();
}

class Media extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get filename => text()();
  TextColumn get path => text()();
  TextColumn get checksum => text().withDefault(const Constant(''))();
}

class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(
  tables: [
    Decks,
    NoteTypes,
    Fields,
    Templates,
    Notes,
    NoteFields,
    Cards,
    Reviews,
    Media,
    Settings,
  ],
)
class LumenDatabase extends _$LumenDatabase {
  LumenDatabase() : super(_open());

  LumenDatabase.memory() : super(NativeDatabase.memory());

  LumenDatabase.connect(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seed(this);
        },
      );

  Future<void> upsertSetting(String key, String value) {
    return into(settings).insertOnConflictUpdate(
      SettingsCompanion.insert(key: key, value: value),
    );
  }

  Future<String?> readSetting(String key) async {
    final row = await (select(settings)..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }
}

Future<void> _seed(LumenDatabase db) async {
  final deckId = await db.into(db.decks).insert(
        DecksCompanion.insert(name: 'Inbox', fullName: 'Inbox'),
      );
  final typeId = await db.into(db.noteTypes).insert(
        NoteTypesCompanion.insert(name: 'Basic'),
      );
  final frontField = await db.into(db.fields).insert(
        FieldsCompanion.insert(noteTypeId: typeId, name: 'Front', ordinal: 0),
      );
  await db.into(db.fields).insert(
        FieldsCompanion.insert(noteTypeId: typeId, name: 'Back', ordinal: 1),
      );
  await db.into(db.templates).insert(
        TemplatesCompanion.insert(
          noteTypeId: typeId,
          name: 'Card 1',
          frontHtml: '{{Front}}',
          backHtml: '{{FrontSide}}<hr id=answer>{{Back}}',
          ordinal: 0,
        ),
      );
  await db.upsertSetting('default_deck_id', '$deckId');
  await db.upsertSetting('default_note_type_id', '$typeId');
  await db.upsertSetting('default_front_field_id', '$frontField');
  await db.upsertSetting('new_per_day', '20');
  await db.upsertSetting('desired_retention', '0.90');
  await db.upsertSetting('theme', 'system');
}

LazyDatabase _open() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final file = File(p.join(dir.path, 'lumen.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
