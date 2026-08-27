// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DecksTable extends Decks with TableInfo<$DecksTable, Deck> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DecksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ankiDeckIdMeta =
      const VerificationMeta('ankiDeckId');
  @override
  late final GeneratedColumn<int> ankiDeckId = GeneratedColumn<int>(
      'anki_deck_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _newPerDayMeta =
      const VerificationMeta('newPerDay');
  @override
  late final GeneratedColumn<int> newPerDay = GeneratedColumn<int>(
      'new_per_day', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(20));
  static const VerificationMeta _revPerDayMeta =
      const VerificationMeta('revPerDay');
  @override
  late final GeneratedColumn<int> revPerDay = GeneratedColumn<int>(
      'rev_per_day', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(200));
  static const VerificationMeta _isFilteredMeta =
      const VerificationMeta('isFiltered');
  @override
  late final GeneratedColumn<bool> isFiltered = GeneratedColumn<bool>(
      'is_filtered', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_filtered" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        parentId,
        name,
        fullName,
        ankiDeckId,
        newPerDay,
        revPerDay,
        isFiltered
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'decks';
  @override
  VerificationContext validateIntegrity(Insertable<Deck> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('anki_deck_id')) {
      context.handle(
          _ankiDeckIdMeta,
          ankiDeckId.isAcceptableOrUnknown(
              data['anki_deck_id']!, _ankiDeckIdMeta));
    }
    if (data.containsKey('new_per_day')) {
      context.handle(
          _newPerDayMeta,
          newPerDay.isAcceptableOrUnknown(
              data['new_per_day']!, _newPerDayMeta));
    }
    if (data.containsKey('rev_per_day')) {
      context.handle(
          _revPerDayMeta,
          revPerDay.isAcceptableOrUnknown(
              data['rev_per_day']!, _revPerDayMeta));
    }
    if (data.containsKey('is_filtered')) {
      context.handle(
          _isFilteredMeta,
          isFiltered.isAcceptableOrUnknown(
              data['is_filtered']!, _isFilteredMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Deck map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Deck(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      ankiDeckId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}anki_deck_id']),
      newPerDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}new_per_day'])!,
      revPerDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rev_per_day'])!,
      isFiltered: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_filtered'])!,
    );
  }

  @override
  $DecksTable createAlias(String alias) {
    return $DecksTable(attachedDatabase, alias);
  }
}

class Deck extends DataClass implements Insertable<Deck> {
  final int id;
  final int? parentId;
  final String name;
  final String fullName;
  final int? ankiDeckId;
  final int newPerDay;
  final int revPerDay;
  final bool isFiltered;
  const Deck(
      {required this.id,
      this.parentId,
      required this.name,
      required this.fullName,
      this.ankiDeckId,
      required this.newPerDay,
      required this.revPerDay,
      required this.isFiltered});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['name'] = Variable<String>(name);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || ankiDeckId != null) {
      map['anki_deck_id'] = Variable<int>(ankiDeckId);
    }
    map['new_per_day'] = Variable<int>(newPerDay);
    map['rev_per_day'] = Variable<int>(revPerDay);
    map['is_filtered'] = Variable<bool>(isFiltered);
    return map;
  }

  DecksCompanion toCompanion(bool nullToAbsent) {
    return DecksCompanion(
      id: Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      name: Value(name),
      fullName: Value(fullName),
      ankiDeckId: ankiDeckId == null && nullToAbsent
          ? const Value.absent()
          : Value(ankiDeckId),
      newPerDay: Value(newPerDay),
      revPerDay: Value(revPerDay),
      isFiltered: Value(isFiltered),
    );
  }

  factory Deck.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Deck(
      id: serializer.fromJson<int>(json['id']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      name: serializer.fromJson<String>(json['name']),
      fullName: serializer.fromJson<String>(json['fullName']),
      ankiDeckId: serializer.fromJson<int?>(json['ankiDeckId']),
      newPerDay: serializer.fromJson<int>(json['newPerDay']),
      revPerDay: serializer.fromJson<int>(json['revPerDay']),
      isFiltered: serializer.fromJson<bool>(json['isFiltered']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'parentId': serializer.toJson<int?>(parentId),
      'name': serializer.toJson<String>(name),
      'fullName': serializer.toJson<String>(fullName),
      'ankiDeckId': serializer.toJson<int?>(ankiDeckId),
      'newPerDay': serializer.toJson<int>(newPerDay),
      'revPerDay': serializer.toJson<int>(revPerDay),
      'isFiltered': serializer.toJson<bool>(isFiltered),
    };
  }

  Deck copyWith(
          {int? id,
          Value<int?> parentId = const Value.absent(),
          String? name,
          String? fullName,
          Value<int?> ankiDeckId = const Value.absent(),
          int? newPerDay,
          int? revPerDay,
          bool? isFiltered}) =>
      Deck(
        id: id ?? this.id,
        parentId: parentId.present ? parentId.value : this.parentId,
        name: name ?? this.name,
        fullName: fullName ?? this.fullName,
        ankiDeckId: ankiDeckId.present ? ankiDeckId.value : this.ankiDeckId,
        newPerDay: newPerDay ?? this.newPerDay,
        revPerDay: revPerDay ?? this.revPerDay,
        isFiltered: isFiltered ?? this.isFiltered,
      );
  Deck copyWithCompanion(DecksCompanion data) {
    return Deck(
      id: data.id.present ? data.id.value : this.id,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      name: data.name.present ? data.name.value : this.name,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      ankiDeckId:
          data.ankiDeckId.present ? data.ankiDeckId.value : this.ankiDeckId,
      newPerDay: data.newPerDay.present ? data.newPerDay.value : this.newPerDay,
      revPerDay: data.revPerDay.present ? data.revPerDay.value : this.revPerDay,
      isFiltered:
          data.isFiltered.present ? data.isFiltered.value : this.isFiltered,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Deck(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('name: $name, ')
          ..write('fullName: $fullName, ')
          ..write('ankiDeckId: $ankiDeckId, ')
          ..write('newPerDay: $newPerDay, ')
          ..write('revPerDay: $revPerDay, ')
          ..write('isFiltered: $isFiltered')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, parentId, name, fullName, ankiDeckId,
      newPerDay, revPerDay, isFiltered);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Deck &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.name == this.name &&
          other.fullName == this.fullName &&
          other.ankiDeckId == this.ankiDeckId &&
          other.newPerDay == this.newPerDay &&
          other.revPerDay == this.revPerDay &&
          other.isFiltered == this.isFiltered);
}

class DecksCompanion extends UpdateCompanion<Deck> {
  final Value<int> id;
  final Value<int?> parentId;
  final Value<String> name;
  final Value<String> fullName;
  final Value<int?> ankiDeckId;
  final Value<int> newPerDay;
  final Value<int> revPerDay;
  final Value<bool> isFiltered;
  const DecksCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.name = const Value.absent(),
    this.fullName = const Value.absent(),
    this.ankiDeckId = const Value.absent(),
    this.newPerDay = const Value.absent(),
    this.revPerDay = const Value.absent(),
    this.isFiltered = const Value.absent(),
  });
  DecksCompanion.insert({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    required String name,
    required String fullName,
    this.ankiDeckId = const Value.absent(),
    this.newPerDay = const Value.absent(),
    this.revPerDay = const Value.absent(),
    this.isFiltered = const Value.absent(),
  })  : name = Value(name),
        fullName = Value(fullName);
  static Insertable<Deck> custom({
    Expression<int>? id,
    Expression<int>? parentId,
    Expression<String>? name,
    Expression<String>? fullName,
    Expression<int>? ankiDeckId,
    Expression<int>? newPerDay,
    Expression<int>? revPerDay,
    Expression<bool>? isFiltered,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentId != null) 'parent_id': parentId,
      if (name != null) 'name': name,
      if (fullName != null) 'full_name': fullName,
      if (ankiDeckId != null) 'anki_deck_id': ankiDeckId,
      if (newPerDay != null) 'new_per_day': newPerDay,
      if (revPerDay != null) 'rev_per_day': revPerDay,
      if (isFiltered != null) 'is_filtered': isFiltered,
    });
  }

  DecksCompanion copyWith(
      {Value<int>? id,
      Value<int?>? parentId,
      Value<String>? name,
      Value<String>? fullName,
      Value<int?>? ankiDeckId,
      Value<int>? newPerDay,
      Value<int>? revPerDay,
      Value<bool>? isFiltered}) {
    return DecksCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      fullName: fullName ?? this.fullName,
      ankiDeckId: ankiDeckId ?? this.ankiDeckId,
      newPerDay: newPerDay ?? this.newPerDay,
      revPerDay: revPerDay ?? this.revPerDay,
      isFiltered: isFiltered ?? this.isFiltered,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (ankiDeckId.present) {
      map['anki_deck_id'] = Variable<int>(ankiDeckId.value);
    }
    if (newPerDay.present) {
      map['new_per_day'] = Variable<int>(newPerDay.value);
    }
    if (revPerDay.present) {
      map['rev_per_day'] = Variable<int>(revPerDay.value);
    }
    if (isFiltered.present) {
      map['is_filtered'] = Variable<bool>(isFiltered.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DecksCompanion(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('name: $name, ')
          ..write('fullName: $fullName, ')
          ..write('ankiDeckId: $ankiDeckId, ')
          ..write('newPerDay: $newPerDay, ')
          ..write('revPerDay: $revPerDay, ')
          ..write('isFiltered: $isFiltered')
          ..write(')'))
        .toString();
  }
}

class $NoteTypesTable extends NoteTypes
    with TableInfo<$NoteTypesTable, NoteType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NoteTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ankiModelIdMeta =
      const VerificationMeta('ankiModelId');
  @override
  late final GeneratedColumn<int> ankiModelId = GeneratedColumn<int>(
      'anki_model_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _cssMeta = const VerificationMeta('css');
  @override
  late final GeneratedColumn<String> css = GeneratedColumn<String>(
      'css', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _isClozeMeta =
      const VerificationMeta('isCloze');
  @override
  late final GeneratedColumn<bool> isCloze = GeneratedColumn<bool>(
      'is_cloze', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_cloze" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, name, ankiModelId, css, isCloze];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'note_types';
  @override
  VerificationContext validateIntegrity(Insertable<NoteType> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('anki_model_id')) {
      context.handle(
          _ankiModelIdMeta,
          ankiModelId.isAcceptableOrUnknown(
              data['anki_model_id']!, _ankiModelIdMeta));
    }
    if (data.containsKey('css')) {
      context.handle(
          _cssMeta, css.isAcceptableOrUnknown(data['css']!, _cssMeta));
    }
    if (data.containsKey('is_cloze')) {
      context.handle(_isClozeMeta,
          isCloze.isAcceptableOrUnknown(data['is_cloze']!, _isClozeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoteType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteType(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      ankiModelId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}anki_model_id']),
      css: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}css'])!,
      isCloze: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_cloze'])!,
    );
  }

  @override
  $NoteTypesTable createAlias(String alias) {
    return $NoteTypesTable(attachedDatabase, alias);
  }
}

class NoteType extends DataClass implements Insertable<NoteType> {
  final int id;
  final String name;
  final int? ankiModelId;
  final String css;
  final bool isCloze;
  const NoteType(
      {required this.id,
      required this.name,
      this.ankiModelId,
      required this.css,
      required this.isCloze});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || ankiModelId != null) {
      map['anki_model_id'] = Variable<int>(ankiModelId);
    }
    map['css'] = Variable<String>(css);
    map['is_cloze'] = Variable<bool>(isCloze);
    return map;
  }

  NoteTypesCompanion toCompanion(bool nullToAbsent) {
    return NoteTypesCompanion(
      id: Value(id),
      name: Value(name),
      ankiModelId: ankiModelId == null && nullToAbsent
          ? const Value.absent()
          : Value(ankiModelId),
      css: Value(css),
      isCloze: Value(isCloze),
    );
  }

  factory NoteType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteType(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      ankiModelId: serializer.fromJson<int?>(json['ankiModelId']),
      css: serializer.fromJson<String>(json['css']),
      isCloze: serializer.fromJson<bool>(json['isCloze']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'ankiModelId': serializer.toJson<int?>(ankiModelId),
      'css': serializer.toJson<String>(css),
      'isCloze': serializer.toJson<bool>(isCloze),
    };
  }

  NoteType copyWith(
          {int? id,
          String? name,
          Value<int?> ankiModelId = const Value.absent(),
          String? css,
          bool? isCloze}) =>
      NoteType(
        id: id ?? this.id,
        name: name ?? this.name,
        ankiModelId: ankiModelId.present ? ankiModelId.value : this.ankiModelId,
        css: css ?? this.css,
        isCloze: isCloze ?? this.isCloze,
      );
  NoteType copyWithCompanion(NoteTypesCompanion data) {
    return NoteType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      ankiModelId:
          data.ankiModelId.present ? data.ankiModelId.value : this.ankiModelId,
      css: data.css.present ? data.css.value : this.css,
      isCloze: data.isCloze.present ? data.isCloze.value : this.isCloze,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NoteType(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ankiModelId: $ankiModelId, ')
          ..write('css: $css, ')
          ..write('isCloze: $isCloze')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, ankiModelId, css, isCloze);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteType &&
          other.id == this.id &&
          other.name == this.name &&
          other.ankiModelId == this.ankiModelId &&
          other.css == this.css &&
          other.isCloze == this.isCloze);
}

class NoteTypesCompanion extends UpdateCompanion<NoteType> {
  final Value<int> id;
  final Value<String> name;
  final Value<int?> ankiModelId;
  final Value<String> css;
  final Value<bool> isCloze;
  const NoteTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.ankiModelId = const Value.absent(),
    this.css = const Value.absent(),
    this.isCloze = const Value.absent(),
  });
  NoteTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.ankiModelId = const Value.absent(),
    this.css = const Value.absent(),
    this.isCloze = const Value.absent(),
  }) : name = Value(name);
  static Insertable<NoteType> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? ankiModelId,
    Expression<String>? css,
    Expression<bool>? isCloze,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (ankiModelId != null) 'anki_model_id': ankiModelId,
      if (css != null) 'css': css,
      if (isCloze != null) 'is_cloze': isCloze,
    });
  }

  NoteTypesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int?>? ankiModelId,
      Value<String>? css,
      Value<bool>? isCloze}) {
    return NoteTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      ankiModelId: ankiModelId ?? this.ankiModelId,
      css: css ?? this.css,
      isCloze: isCloze ?? this.isCloze,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (ankiModelId.present) {
      map['anki_model_id'] = Variable<int>(ankiModelId.value);
    }
    if (css.present) {
      map['css'] = Variable<String>(css.value);
    }
    if (isCloze.present) {
      map['is_cloze'] = Variable<bool>(isCloze.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NoteTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ankiModelId: $ankiModelId, ')
          ..write('css: $css, ')
          ..write('isCloze: $isCloze')
          ..write(')'))
        .toString();
  }
}

class $FieldsTable extends Fields with TableInfo<$FieldsTable, Field> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FieldsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _noteTypeIdMeta =
      const VerificationMeta('noteTypeId');
  @override
  late final GeneratedColumn<int> noteTypeId = GeneratedColumn<int>(
      'note_type_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ordinalMeta =
      const VerificationMeta('ordinal');
  @override
  late final GeneratedColumn<int> ordinal = GeneratedColumn<int>(
      'ordinal', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, noteTypeId, name, ordinal];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fields';
  @override
  VerificationContext validateIntegrity(Insertable<Field> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('note_type_id')) {
      context.handle(
          _noteTypeIdMeta,
          noteTypeId.isAcceptableOrUnknown(
              data['note_type_id']!, _noteTypeIdMeta));
    } else if (isInserting) {
      context.missing(_noteTypeIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('ordinal')) {
      context.handle(_ordinalMeta,
          ordinal.isAcceptableOrUnknown(data['ordinal']!, _ordinalMeta));
    } else if (isInserting) {
      context.missing(_ordinalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Field map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Field(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      noteTypeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}note_type_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      ordinal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordinal'])!,
    );
  }

  @override
  $FieldsTable createAlias(String alias) {
    return $FieldsTable(attachedDatabase, alias);
  }
}

class Field extends DataClass implements Insertable<Field> {
  final int id;
  final int noteTypeId;
  final String name;
  final int ordinal;
  const Field(
      {required this.id,
      required this.noteTypeId,
      required this.name,
      required this.ordinal});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['note_type_id'] = Variable<int>(noteTypeId);
    map['name'] = Variable<String>(name);
    map['ordinal'] = Variable<int>(ordinal);
    return map;
  }

  FieldsCompanion toCompanion(bool nullToAbsent) {
    return FieldsCompanion(
      id: Value(id),
      noteTypeId: Value(noteTypeId),
      name: Value(name),
      ordinal: Value(ordinal),
    );
  }

  factory Field.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Field(
      id: serializer.fromJson<int>(json['id']),
      noteTypeId: serializer.fromJson<int>(json['noteTypeId']),
      name: serializer.fromJson<String>(json['name']),
      ordinal: serializer.fromJson<int>(json['ordinal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'noteTypeId': serializer.toJson<int>(noteTypeId),
      'name': serializer.toJson<String>(name),
      'ordinal': serializer.toJson<int>(ordinal),
    };
  }

  Field copyWith({int? id, int? noteTypeId, String? name, int? ordinal}) =>
      Field(
        id: id ?? this.id,
        noteTypeId: noteTypeId ?? this.noteTypeId,
        name: name ?? this.name,
        ordinal: ordinal ?? this.ordinal,
      );
  Field copyWithCompanion(FieldsCompanion data) {
    return Field(
      id: data.id.present ? data.id.value : this.id,
      noteTypeId:
          data.noteTypeId.present ? data.noteTypeId.value : this.noteTypeId,
      name: data.name.present ? data.name.value : this.name,
      ordinal: data.ordinal.present ? data.ordinal.value : this.ordinal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Field(')
          ..write('id: $id, ')
          ..write('noteTypeId: $noteTypeId, ')
          ..write('name: $name, ')
          ..write('ordinal: $ordinal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, noteTypeId, name, ordinal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Field &&
          other.id == this.id &&
          other.noteTypeId == this.noteTypeId &&
          other.name == this.name &&
          other.ordinal == this.ordinal);
}

class FieldsCompanion extends UpdateCompanion<Field> {
  final Value<int> id;
  final Value<int> noteTypeId;
  final Value<String> name;
  final Value<int> ordinal;
  const FieldsCompanion({
    this.id = const Value.absent(),
    this.noteTypeId = const Value.absent(),
    this.name = const Value.absent(),
    this.ordinal = const Value.absent(),
  });
  FieldsCompanion.insert({
    this.id = const Value.absent(),
    required int noteTypeId,
    required String name,
    required int ordinal,
  })  : noteTypeId = Value(noteTypeId),
        name = Value(name),
        ordinal = Value(ordinal);
  static Insertable<Field> custom({
    Expression<int>? id,
    Expression<int>? noteTypeId,
    Expression<String>? name,
    Expression<int>? ordinal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noteTypeId != null) 'note_type_id': noteTypeId,
      if (name != null) 'name': name,
      if (ordinal != null) 'ordinal': ordinal,
    });
  }

  FieldsCompanion copyWith(
      {Value<int>? id,
      Value<int>? noteTypeId,
      Value<String>? name,
      Value<int>? ordinal}) {
    return FieldsCompanion(
      id: id ?? this.id,
      noteTypeId: noteTypeId ?? this.noteTypeId,
      name: name ?? this.name,
      ordinal: ordinal ?? this.ordinal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (noteTypeId.present) {
      map['note_type_id'] = Variable<int>(noteTypeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (ordinal.present) {
      map['ordinal'] = Variable<int>(ordinal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FieldsCompanion(')
          ..write('id: $id, ')
          ..write('noteTypeId: $noteTypeId, ')
          ..write('name: $name, ')
          ..write('ordinal: $ordinal')
          ..write(')'))
        .toString();
  }
}

class $TemplatesTable extends Templates
    with TableInfo<$TemplatesTable, Template> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _noteTypeIdMeta =
      const VerificationMeta('noteTypeId');
  @override
  late final GeneratedColumn<int> noteTypeId = GeneratedColumn<int>(
      'note_type_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _frontHtmlMeta =
      const VerificationMeta('frontHtml');
  @override
  late final GeneratedColumn<String> frontHtml = GeneratedColumn<String>(
      'front_html', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _backHtmlMeta =
      const VerificationMeta('backHtml');
  @override
  late final GeneratedColumn<String> backHtml = GeneratedColumn<String>(
      'back_html', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ordinalMeta =
      const VerificationMeta('ordinal');
  @override
  late final GeneratedColumn<int> ordinal = GeneratedColumn<int>(
      'ordinal', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, noteTypeId, name, frontHtml, backHtml, ordinal];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'templates';
  @override
  VerificationContext validateIntegrity(Insertable<Template> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('note_type_id')) {
      context.handle(
          _noteTypeIdMeta,
          noteTypeId.isAcceptableOrUnknown(
              data['note_type_id']!, _noteTypeIdMeta));
    } else if (isInserting) {
      context.missing(_noteTypeIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('front_html')) {
      context.handle(_frontHtmlMeta,
          frontHtml.isAcceptableOrUnknown(data['front_html']!, _frontHtmlMeta));
    } else if (isInserting) {
      context.missing(_frontHtmlMeta);
    }
    if (data.containsKey('back_html')) {
      context.handle(_backHtmlMeta,
          backHtml.isAcceptableOrUnknown(data['back_html']!, _backHtmlMeta));
    } else if (isInserting) {
      context.missing(_backHtmlMeta);
    }
    if (data.containsKey('ordinal')) {
      context.handle(_ordinalMeta,
          ordinal.isAcceptableOrUnknown(data['ordinal']!, _ordinalMeta));
    } else if (isInserting) {
      context.missing(_ordinalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Template map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Template(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      noteTypeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}note_type_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      frontHtml: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}front_html'])!,
      backHtml: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}back_html'])!,
      ordinal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordinal'])!,
    );
  }

  @override
  $TemplatesTable createAlias(String alias) {
    return $TemplatesTable(attachedDatabase, alias);
  }
}

class Template extends DataClass implements Insertable<Template> {
  final int id;
  final int noteTypeId;
  final String name;
  final String frontHtml;
  final String backHtml;
  final int ordinal;
  const Template(
      {required this.id,
      required this.noteTypeId,
      required this.name,
      required this.frontHtml,
      required this.backHtml,
      required this.ordinal});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['note_type_id'] = Variable<int>(noteTypeId);
    map['name'] = Variable<String>(name);
    map['front_html'] = Variable<String>(frontHtml);
    map['back_html'] = Variable<String>(backHtml);
    map['ordinal'] = Variable<int>(ordinal);
    return map;
  }

  TemplatesCompanion toCompanion(bool nullToAbsent) {
    return TemplatesCompanion(
      id: Value(id),
      noteTypeId: Value(noteTypeId),
      name: Value(name),
      frontHtml: Value(frontHtml),
      backHtml: Value(backHtml),
      ordinal: Value(ordinal),
    );
  }

  factory Template.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Template(
      id: serializer.fromJson<int>(json['id']),
      noteTypeId: serializer.fromJson<int>(json['noteTypeId']),
      name: serializer.fromJson<String>(json['name']),
      frontHtml: serializer.fromJson<String>(json['frontHtml']),
      backHtml: serializer.fromJson<String>(json['backHtml']),
      ordinal: serializer.fromJson<int>(json['ordinal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'noteTypeId': serializer.toJson<int>(noteTypeId),
      'name': serializer.toJson<String>(name),
      'frontHtml': serializer.toJson<String>(frontHtml),
      'backHtml': serializer.toJson<String>(backHtml),
      'ordinal': serializer.toJson<int>(ordinal),
    };
  }

  Template copyWith(
          {int? id,
          int? noteTypeId,
          String? name,
          String? frontHtml,
          String? backHtml,
          int? ordinal}) =>
      Template(
        id: id ?? this.id,
        noteTypeId: noteTypeId ?? this.noteTypeId,
        name: name ?? this.name,
        frontHtml: frontHtml ?? this.frontHtml,
        backHtml: backHtml ?? this.backHtml,
        ordinal: ordinal ?? this.ordinal,
      );
  Template copyWithCompanion(TemplatesCompanion data) {
    return Template(
      id: data.id.present ? data.id.value : this.id,
      noteTypeId:
          data.noteTypeId.present ? data.noteTypeId.value : this.noteTypeId,
      name: data.name.present ? data.name.value : this.name,
      frontHtml: data.frontHtml.present ? data.frontHtml.value : this.frontHtml,
      backHtml: data.backHtml.present ? data.backHtml.value : this.backHtml,
      ordinal: data.ordinal.present ? data.ordinal.value : this.ordinal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Template(')
          ..write('id: $id, ')
          ..write('noteTypeId: $noteTypeId, ')
          ..write('name: $name, ')
          ..write('frontHtml: $frontHtml, ')
          ..write('backHtml: $backHtml, ')
          ..write('ordinal: $ordinal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, noteTypeId, name, frontHtml, backHtml, ordinal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Template &&
          other.id == this.id &&
          other.noteTypeId == this.noteTypeId &&
          other.name == this.name &&
          other.frontHtml == this.frontHtml &&
          other.backHtml == this.backHtml &&
          other.ordinal == this.ordinal);
}

class TemplatesCompanion extends UpdateCompanion<Template> {
  final Value<int> id;
  final Value<int> noteTypeId;
  final Value<String> name;
  final Value<String> frontHtml;
  final Value<String> backHtml;
  final Value<int> ordinal;
  const TemplatesCompanion({
    this.id = const Value.absent(),
    this.noteTypeId = const Value.absent(),
    this.name = const Value.absent(),
    this.frontHtml = const Value.absent(),
    this.backHtml = const Value.absent(),
    this.ordinal = const Value.absent(),
  });
  TemplatesCompanion.insert({
    this.id = const Value.absent(),
    required int noteTypeId,
    required String name,
    required String frontHtml,
    required String backHtml,
    required int ordinal,
  })  : noteTypeId = Value(noteTypeId),
        name = Value(name),
        frontHtml = Value(frontHtml),
        backHtml = Value(backHtml),
        ordinal = Value(ordinal);
  static Insertable<Template> custom({
    Expression<int>? id,
    Expression<int>? noteTypeId,
    Expression<String>? name,
    Expression<String>? frontHtml,
    Expression<String>? backHtml,
    Expression<int>? ordinal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noteTypeId != null) 'note_type_id': noteTypeId,
      if (name != null) 'name': name,
      if (frontHtml != null) 'front_html': frontHtml,
      if (backHtml != null) 'back_html': backHtml,
      if (ordinal != null) 'ordinal': ordinal,
    });
  }

  TemplatesCompanion copyWith(
      {Value<int>? id,
      Value<int>? noteTypeId,
      Value<String>? name,
      Value<String>? frontHtml,
      Value<String>? backHtml,
      Value<int>? ordinal}) {
    return TemplatesCompanion(
      id: id ?? this.id,
      noteTypeId: noteTypeId ?? this.noteTypeId,
      name: name ?? this.name,
      frontHtml: frontHtml ?? this.frontHtml,
      backHtml: backHtml ?? this.backHtml,
      ordinal: ordinal ?? this.ordinal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (noteTypeId.present) {
      map['note_type_id'] = Variable<int>(noteTypeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (frontHtml.present) {
      map['front_html'] = Variable<String>(frontHtml.value);
    }
    if (backHtml.present) {
      map['back_html'] = Variable<String>(backHtml.value);
    }
    if (ordinal.present) {
      map['ordinal'] = Variable<int>(ordinal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemplatesCompanion(')
          ..write('id: $id, ')
          ..write('noteTypeId: $noteTypeId, ')
          ..write('name: $name, ')
          ..write('frontHtml: $frontHtml, ')
          ..write('backHtml: $backHtml, ')
          ..write('ordinal: $ordinal')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _noteTypeIdMeta =
      const VerificationMeta('noteTypeId');
  @override
  late final GeneratedColumn<int> noteTypeId = GeneratedColumn<int>(
      'note_type_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ankiNoteIdMeta =
      const VerificationMeta('ankiNoteId');
  @override
  late final GeneratedColumn<int> ankiNoteId = GeneratedColumn<int>(
      'anki_note_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _modifiedAtMeta =
      const VerificationMeta('modifiedAt');
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
      'modified_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, noteTypeId, ankiNoteId, tags, modifiedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<Note> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('note_type_id')) {
      context.handle(
          _noteTypeIdMeta,
          noteTypeId.isAcceptableOrUnknown(
              data['note_type_id']!, _noteTypeIdMeta));
    } else if (isInserting) {
      context.missing(_noteTypeIdMeta);
    }
    if (data.containsKey('anki_note_id')) {
      context.handle(
          _ankiNoteIdMeta,
          ankiNoteId.isAcceptableOrUnknown(
              data['anki_note_id']!, _ankiNoteIdMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at']!, _modifiedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      noteTypeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}note_type_id'])!,
      ankiNoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}anki_note_id']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
      modifiedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}modified_at'])!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final int id;
  final int noteTypeId;
  final int? ankiNoteId;
  final String tags;
  final DateTime modifiedAt;
  const Note(
      {required this.id,
      required this.noteTypeId,
      this.ankiNoteId,
      required this.tags,
      required this.modifiedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['note_type_id'] = Variable<int>(noteTypeId);
    if (!nullToAbsent || ankiNoteId != null) {
      map['anki_note_id'] = Variable<int>(ankiNoteId);
    }
    map['tags'] = Variable<String>(tags);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      noteTypeId: Value(noteTypeId),
      ankiNoteId: ankiNoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(ankiNoteId),
      tags: Value(tags),
      modifiedAt: Value(modifiedAt),
    );
  }

  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<int>(json['id']),
      noteTypeId: serializer.fromJson<int>(json['noteTypeId']),
      ankiNoteId: serializer.fromJson<int?>(json['ankiNoteId']),
      tags: serializer.fromJson<String>(json['tags']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'noteTypeId': serializer.toJson<int>(noteTypeId),
      'ankiNoteId': serializer.toJson<int?>(ankiNoteId),
      'tags': serializer.toJson<String>(tags),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
    };
  }

  Note copyWith(
          {int? id,
          int? noteTypeId,
          Value<int?> ankiNoteId = const Value.absent(),
          String? tags,
          DateTime? modifiedAt}) =>
      Note(
        id: id ?? this.id,
        noteTypeId: noteTypeId ?? this.noteTypeId,
        ankiNoteId: ankiNoteId.present ? ankiNoteId.value : this.ankiNoteId,
        tags: tags ?? this.tags,
        modifiedAt: modifiedAt ?? this.modifiedAt,
      );
  Note copyWithCompanion(NotesCompanion data) {
    return Note(
      id: data.id.present ? data.id.value : this.id,
      noteTypeId:
          data.noteTypeId.present ? data.noteTypeId.value : this.noteTypeId,
      ankiNoteId:
          data.ankiNoteId.present ? data.ankiNoteId.value : this.ankiNoteId,
      tags: data.tags.present ? data.tags.value : this.tags,
      modifiedAt:
          data.modifiedAt.present ? data.modifiedAt.value : this.modifiedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('noteTypeId: $noteTypeId, ')
          ..write('ankiNoteId: $ankiNoteId, ')
          ..write('tags: $tags, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, noteTypeId, ankiNoteId, tags, modifiedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.noteTypeId == this.noteTypeId &&
          other.ankiNoteId == this.ankiNoteId &&
          other.tags == this.tags &&
          other.modifiedAt == this.modifiedAt);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<int> noteTypeId;
  final Value<int?> ankiNoteId;
  final Value<String> tags;
  final Value<DateTime> modifiedAt;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.noteTypeId = const Value.absent(),
    this.ankiNoteId = const Value.absent(),
    this.tags = const Value.absent(),
    this.modifiedAt = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    required int noteTypeId,
    this.ankiNoteId = const Value.absent(),
    this.tags = const Value.absent(),
    this.modifiedAt = const Value.absent(),
  }) : noteTypeId = Value(noteTypeId);
  static Insertable<Note> custom({
    Expression<int>? id,
    Expression<int>? noteTypeId,
    Expression<int>? ankiNoteId,
    Expression<String>? tags,
    Expression<DateTime>? modifiedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noteTypeId != null) 'note_type_id': noteTypeId,
      if (ankiNoteId != null) 'anki_note_id': ankiNoteId,
      if (tags != null) 'tags': tags,
      if (modifiedAt != null) 'modified_at': modifiedAt,
    });
  }

  NotesCompanion copyWith(
      {Value<int>? id,
      Value<int>? noteTypeId,
      Value<int?>? ankiNoteId,
      Value<String>? tags,
      Value<DateTime>? modifiedAt}) {
    return NotesCompanion(
      id: id ?? this.id,
      noteTypeId: noteTypeId ?? this.noteTypeId,
      ankiNoteId: ankiNoteId ?? this.ankiNoteId,
      tags: tags ?? this.tags,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (noteTypeId.present) {
      map['note_type_id'] = Variable<int>(noteTypeId.value);
    }
    if (ankiNoteId.present) {
      map['anki_note_id'] = Variable<int>(ankiNoteId.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('noteTypeId: $noteTypeId, ')
          ..write('ankiNoteId: $ankiNoteId, ')
          ..write('tags: $tags, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }
}

class $NoteFieldsTable extends NoteFields
    with TableInfo<$NoteFieldsTable, NoteField> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NoteFieldsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<int> noteId = GeneratedColumn<int>(
      'note_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _fieldIdMeta =
      const VerificationMeta('fieldId');
  @override
  late final GeneratedColumn<int> fieldId = GeneratedColumn<int>(
      'field_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, noteId, fieldId, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'note_fields';
  @override
  VerificationContext validateIntegrity(Insertable<NoteField> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('note_id')) {
      context.handle(_noteIdMeta,
          noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta));
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('field_id')) {
      context.handle(_fieldIdMeta,
          fieldId.isAcceptableOrUnknown(data['field_id']!, _fieldIdMeta));
    } else if (isInserting) {
      context.missing(_fieldIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoteField map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteField(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      noteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}note_id'])!,
      fieldId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}field_id'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $NoteFieldsTable createAlias(String alias) {
    return $NoteFieldsTable(attachedDatabase, alias);
  }
}

class NoteField extends DataClass implements Insertable<NoteField> {
  final int id;
  final int noteId;
  final int fieldId;
  final String value;
  const NoteField(
      {required this.id,
      required this.noteId,
      required this.fieldId,
      required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['note_id'] = Variable<int>(noteId);
    map['field_id'] = Variable<int>(fieldId);
    map['value'] = Variable<String>(value);
    return map;
  }

  NoteFieldsCompanion toCompanion(bool nullToAbsent) {
    return NoteFieldsCompanion(
      id: Value(id),
      noteId: Value(noteId),
      fieldId: Value(fieldId),
      value: Value(value),
    );
  }

  factory NoteField.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteField(
      id: serializer.fromJson<int>(json['id']),
      noteId: serializer.fromJson<int>(json['noteId']),
      fieldId: serializer.fromJson<int>(json['fieldId']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'noteId': serializer.toJson<int>(noteId),
      'fieldId': serializer.toJson<int>(fieldId),
      'value': serializer.toJson<String>(value),
    };
  }

  NoteField copyWith({int? id, int? noteId, int? fieldId, String? value}) =>
      NoteField(
        id: id ?? this.id,
        noteId: noteId ?? this.noteId,
        fieldId: fieldId ?? this.fieldId,
        value: value ?? this.value,
      );
  NoteField copyWithCompanion(NoteFieldsCompanion data) {
    return NoteField(
      id: data.id.present ? data.id.value : this.id,
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      fieldId: data.fieldId.present ? data.fieldId.value : this.fieldId,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NoteField(')
          ..write('id: $id, ')
          ..write('noteId: $noteId, ')
          ..write('fieldId: $fieldId, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, noteId, fieldId, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteField &&
          other.id == this.id &&
          other.noteId == this.noteId &&
          other.fieldId == this.fieldId &&
          other.value == this.value);
}

class NoteFieldsCompanion extends UpdateCompanion<NoteField> {
  final Value<int> id;
  final Value<int> noteId;
  final Value<int> fieldId;
  final Value<String> value;
  const NoteFieldsCompanion({
    this.id = const Value.absent(),
    this.noteId = const Value.absent(),
    this.fieldId = const Value.absent(),
    this.value = const Value.absent(),
  });
  NoteFieldsCompanion.insert({
    this.id = const Value.absent(),
    required int noteId,
    required int fieldId,
    required String value,
  })  : noteId = Value(noteId),
        fieldId = Value(fieldId),
        value = Value(value);
  static Insertable<NoteField> custom({
    Expression<int>? id,
    Expression<int>? noteId,
    Expression<int>? fieldId,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noteId != null) 'note_id': noteId,
      if (fieldId != null) 'field_id': fieldId,
      if (value != null) 'value': value,
    });
  }

  NoteFieldsCompanion copyWith(
      {Value<int>? id,
      Value<int>? noteId,
      Value<int>? fieldId,
      Value<String>? value}) {
    return NoteFieldsCompanion(
      id: id ?? this.id,
      noteId: noteId ?? this.noteId,
      fieldId: fieldId ?? this.fieldId,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (noteId.present) {
      map['note_id'] = Variable<int>(noteId.value);
    }
    if (fieldId.present) {
      map['field_id'] = Variable<int>(fieldId.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NoteFieldsCompanion(')
          ..write('id: $id, ')
          ..write('noteId: $noteId, ')
          ..write('fieldId: $fieldId, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $CardsTable extends Cards with TableInfo<$CardsTable, Card> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<int> noteId = GeneratedColumn<int>(
      'note_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _deckIdMeta = const VerificationMeta('deckId');
  @override
  late final GeneratedColumn<int> deckId = GeneratedColumn<int>(
      'deck_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _templateIdMeta =
      const VerificationMeta('templateId');
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
      'template_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ankiCardIdMeta =
      const VerificationMeta('ankiCardId');
  @override
  late final GeneratedColumn<int> ankiCardId = GeneratedColumn<int>(
      'anki_card_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _ordinalMeta =
      const VerificationMeta('ordinal');
  @override
  late final GeneratedColumn<int> ordinal = GeneratedColumn<int>(
      'ordinal', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
      'state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('new'));
  static const VerificationMeta _dueMeta = const VerificationMeta('due');
  @override
  late final GeneratedColumn<DateTime> due = GeneratedColumn<DateTime>(
      'due', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _stabilityMeta =
      const VerificationMeta('stability');
  @override
  late final GeneratedColumn<double> stability = GeneratedColumn<double>(
      'stability', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<double> difficulty = GeneratedColumn<double>(
      'difficulty', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lapsesMeta = const VerificationMeta('lapses');
  @override
  late final GeneratedColumn<int> lapses = GeneratedColumn<int>(
      'lapses', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _scheduledDaysMeta =
      const VerificationMeta('scheduledDays');
  @override
  late final GeneratedColumn<int> scheduledDays = GeneratedColumn<int>(
      'scheduled_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _learningStepsMeta =
      const VerificationMeta('learningSteps');
  @override
  late final GeneratedColumn<int> learningSteps = GeneratedColumn<int>(
      'learning_steps', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastReviewMeta =
      const VerificationMeta('lastReview');
  @override
  late final GeneratedColumn<DateTime> lastReview = GeneratedColumn<DateTime>(
      'last_review', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _firstReviewedAtMeta =
      const VerificationMeta('firstReviewedAt');
  @override
  late final GeneratedColumn<DateTime> firstReviewedAt =
      GeneratedColumn<DateTime>('first_reviewed_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _suspendedMeta =
      const VerificationMeta('suspended');
  @override
  late final GeneratedColumn<bool> suspended = GeneratedColumn<bool>(
      'suspended', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("suspended" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        noteId,
        deckId,
        templateId,
        ankiCardId,
        ordinal,
        state,
        due,
        stability,
        difficulty,
        reps,
        lapses,
        scheduledDays,
        learningSteps,
        lastReview,
        firstReviewedAt,
        suspended
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cards';
  @override
  VerificationContext validateIntegrity(Insertable<Card> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('note_id')) {
      context.handle(_noteIdMeta,
          noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta));
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('deck_id')) {
      context.handle(_deckIdMeta,
          deckId.isAcceptableOrUnknown(data['deck_id']!, _deckIdMeta));
    } else if (isInserting) {
      context.missing(_deckIdMeta);
    }
    if (data.containsKey('template_id')) {
      context.handle(
          _templateIdMeta,
          templateId.isAcceptableOrUnknown(
              data['template_id']!, _templateIdMeta));
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('anki_card_id')) {
      context.handle(
          _ankiCardIdMeta,
          ankiCardId.isAcceptableOrUnknown(
              data['anki_card_id']!, _ankiCardIdMeta));
    }
    if (data.containsKey('ordinal')) {
      context.handle(_ordinalMeta,
          ordinal.isAcceptableOrUnknown(data['ordinal']!, _ordinalMeta));
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    }
    if (data.containsKey('due')) {
      context.handle(
          _dueMeta, due.isAcceptableOrUnknown(data['due']!, _dueMeta));
    } else if (isInserting) {
      context.missing(_dueMeta);
    }
    if (data.containsKey('stability')) {
      context.handle(_stabilityMeta,
          stability.isAcceptableOrUnknown(data['stability']!, _stabilityMeta));
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    }
    if (data.containsKey('lapses')) {
      context.handle(_lapsesMeta,
          lapses.isAcceptableOrUnknown(data['lapses']!, _lapsesMeta));
    }
    if (data.containsKey('scheduled_days')) {
      context.handle(
          _scheduledDaysMeta,
          scheduledDays.isAcceptableOrUnknown(
              data['scheduled_days']!, _scheduledDaysMeta));
    }
    if (data.containsKey('learning_steps')) {
      context.handle(
          _learningStepsMeta,
          learningSteps.isAcceptableOrUnknown(
              data['learning_steps']!, _learningStepsMeta));
    }
    if (data.containsKey('last_review')) {
      context.handle(
          _lastReviewMeta,
          lastReview.isAcceptableOrUnknown(
              data['last_review']!, _lastReviewMeta));
    }
    if (data.containsKey('first_reviewed_at')) {
      context.handle(
          _firstReviewedAtMeta,
          firstReviewedAt.isAcceptableOrUnknown(
              data['first_reviewed_at']!, _firstReviewedAtMeta));
    }
    if (data.containsKey('suspended')) {
      context.handle(_suspendedMeta,
          suspended.isAcceptableOrUnknown(data['suspended']!, _suspendedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Card map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Card(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      noteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}note_id'])!,
      deckId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deck_id'])!,
      templateId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}template_id'])!,
      ankiCardId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}anki_card_id']),
      ordinal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordinal'])!,
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state'])!,
      due: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due'])!,
      stability: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}stability']),
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}difficulty']),
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reps'])!,
      lapses: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lapses'])!,
      scheduledDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}scheduled_days'])!,
      learningSteps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}learning_steps'])!,
      lastReview: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_review']),
      firstReviewedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}first_reviewed_at']),
      suspended: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}suspended'])!,
    );
  }

  @override
  $CardsTable createAlias(String alias) {
    return $CardsTable(attachedDatabase, alias);
  }
}

class Card extends DataClass implements Insertable<Card> {
  final int id;
  final int noteId;
  final int deckId;
  final int templateId;
  final int? ankiCardId;
  final int ordinal;
  final String state;
  final DateTime due;
  final double? stability;
  final double? difficulty;
  final int reps;
  final int lapses;
  final int scheduledDays;
  final int learningSteps;
  final DateTime? lastReview;
  final DateTime? firstReviewedAt;
  final bool suspended;
  const Card(
      {required this.id,
      required this.noteId,
      required this.deckId,
      required this.templateId,
      this.ankiCardId,
      required this.ordinal,
      required this.state,
      required this.due,
      this.stability,
      this.difficulty,
      required this.reps,
      required this.lapses,
      required this.scheduledDays,
      required this.learningSteps,
      this.lastReview,
      this.firstReviewedAt,
      required this.suspended});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['note_id'] = Variable<int>(noteId);
    map['deck_id'] = Variable<int>(deckId);
    map['template_id'] = Variable<int>(templateId);
    if (!nullToAbsent || ankiCardId != null) {
      map['anki_card_id'] = Variable<int>(ankiCardId);
    }
    map['ordinal'] = Variable<int>(ordinal);
    map['state'] = Variable<String>(state);
    map['due'] = Variable<DateTime>(due);
    if (!nullToAbsent || stability != null) {
      map['stability'] = Variable<double>(stability);
    }
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<double>(difficulty);
    }
    map['reps'] = Variable<int>(reps);
    map['lapses'] = Variable<int>(lapses);
    map['scheduled_days'] = Variable<int>(scheduledDays);
    map['learning_steps'] = Variable<int>(learningSteps);
    if (!nullToAbsent || lastReview != null) {
      map['last_review'] = Variable<DateTime>(lastReview);
    }
    if (!nullToAbsent || firstReviewedAt != null) {
      map['first_reviewed_at'] = Variable<DateTime>(firstReviewedAt);
    }
    map['suspended'] = Variable<bool>(suspended);
    return map;
  }

  CardsCompanion toCompanion(bool nullToAbsent) {
    return CardsCompanion(
      id: Value(id),
      noteId: Value(noteId),
      deckId: Value(deckId),
      templateId: Value(templateId),
      ankiCardId: ankiCardId == null && nullToAbsent
          ? const Value.absent()
          : Value(ankiCardId),
      ordinal: Value(ordinal),
      state: Value(state),
      due: Value(due),
      stability: stability == null && nullToAbsent
          ? const Value.absent()
          : Value(stability),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
      reps: Value(reps),
      lapses: Value(lapses),
      scheduledDays: Value(scheduledDays),
      learningSteps: Value(learningSteps),
      lastReview: lastReview == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReview),
      firstReviewedAt: firstReviewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(firstReviewedAt),
      suspended: Value(suspended),
    );
  }

  factory Card.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Card(
      id: serializer.fromJson<int>(json['id']),
      noteId: serializer.fromJson<int>(json['noteId']),
      deckId: serializer.fromJson<int>(json['deckId']),
      templateId: serializer.fromJson<int>(json['templateId']),
      ankiCardId: serializer.fromJson<int?>(json['ankiCardId']),
      ordinal: serializer.fromJson<int>(json['ordinal']),
      state: serializer.fromJson<String>(json['state']),
      due: serializer.fromJson<DateTime>(json['due']),
      stability: serializer.fromJson<double?>(json['stability']),
      difficulty: serializer.fromJson<double?>(json['difficulty']),
      reps: serializer.fromJson<int>(json['reps']),
      lapses: serializer.fromJson<int>(json['lapses']),
      scheduledDays: serializer.fromJson<int>(json['scheduledDays']),
      learningSteps: serializer.fromJson<int>(json['learningSteps']),
      lastReview: serializer.fromJson<DateTime?>(json['lastReview']),
      firstReviewedAt: serializer.fromJson<DateTime?>(json['firstReviewedAt']),
      suspended: serializer.fromJson<bool>(json['suspended']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'noteId': serializer.toJson<int>(noteId),
      'deckId': serializer.toJson<int>(deckId),
      'templateId': serializer.toJson<int>(templateId),
      'ankiCardId': serializer.toJson<int?>(ankiCardId),
      'ordinal': serializer.toJson<int>(ordinal),
      'state': serializer.toJson<String>(state),
      'due': serializer.toJson<DateTime>(due),
      'stability': serializer.toJson<double?>(stability),
      'difficulty': serializer.toJson<double?>(difficulty),
      'reps': serializer.toJson<int>(reps),
      'lapses': serializer.toJson<int>(lapses),
      'scheduledDays': serializer.toJson<int>(scheduledDays),
      'learningSteps': serializer.toJson<int>(learningSteps),
      'lastReview': serializer.toJson<DateTime?>(lastReview),
      'firstReviewedAt': serializer.toJson<DateTime?>(firstReviewedAt),
      'suspended': serializer.toJson<bool>(suspended),
    };
  }

  Card copyWith(
          {int? id,
          int? noteId,
          int? deckId,
          int? templateId,
          Value<int?> ankiCardId = const Value.absent(),
          int? ordinal,
          String? state,
          DateTime? due,
          Value<double?> stability = const Value.absent(),
          Value<double?> difficulty = const Value.absent(),
          int? reps,
          int? lapses,
          int? scheduledDays,
          int? learningSteps,
          Value<DateTime?> lastReview = const Value.absent(),
          Value<DateTime?> firstReviewedAt = const Value.absent(),
          bool? suspended}) =>
      Card(
        id: id ?? this.id,
        noteId: noteId ?? this.noteId,
        deckId: deckId ?? this.deckId,
        templateId: templateId ?? this.templateId,
        ankiCardId: ankiCardId.present ? ankiCardId.value : this.ankiCardId,
        ordinal: ordinal ?? this.ordinal,
        state: state ?? this.state,
        due: due ?? this.due,
        stability: stability.present ? stability.value : this.stability,
        difficulty: difficulty.present ? difficulty.value : this.difficulty,
        reps: reps ?? this.reps,
        lapses: lapses ?? this.lapses,
        scheduledDays: scheduledDays ?? this.scheduledDays,
        learningSteps: learningSteps ?? this.learningSteps,
        lastReview: lastReview.present ? lastReview.value : this.lastReview,
        firstReviewedAt: firstReviewedAt.present
            ? firstReviewedAt.value
            : this.firstReviewedAt,
        suspended: suspended ?? this.suspended,
      );
  Card copyWithCompanion(CardsCompanion data) {
    return Card(
      id: data.id.present ? data.id.value : this.id,
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      deckId: data.deckId.present ? data.deckId.value : this.deckId,
      templateId:
          data.templateId.present ? data.templateId.value : this.templateId,
      ankiCardId:
          data.ankiCardId.present ? data.ankiCardId.value : this.ankiCardId,
      ordinal: data.ordinal.present ? data.ordinal.value : this.ordinal,
      state: data.state.present ? data.state.value : this.state,
      due: data.due.present ? data.due.value : this.due,
      stability: data.stability.present ? data.stability.value : this.stability,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      reps: data.reps.present ? data.reps.value : this.reps,
      lapses: data.lapses.present ? data.lapses.value : this.lapses,
      scheduledDays: data.scheduledDays.present
          ? data.scheduledDays.value
          : this.scheduledDays,
      learningSteps: data.learningSteps.present
          ? data.learningSteps.value
          : this.learningSteps,
      lastReview:
          data.lastReview.present ? data.lastReview.value : this.lastReview,
      firstReviewedAt: data.firstReviewedAt.present
          ? data.firstReviewedAt.value
          : this.firstReviewedAt,
      suspended: data.suspended.present ? data.suspended.value : this.suspended,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Card(')
          ..write('id: $id, ')
          ..write('noteId: $noteId, ')
          ..write('deckId: $deckId, ')
          ..write('templateId: $templateId, ')
          ..write('ankiCardId: $ankiCardId, ')
          ..write('ordinal: $ordinal, ')
          ..write('state: $state, ')
          ..write('due: $due, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty, ')
          ..write('reps: $reps, ')
          ..write('lapses: $lapses, ')
          ..write('scheduledDays: $scheduledDays, ')
          ..write('learningSteps: $learningSteps, ')
          ..write('lastReview: $lastReview, ')
          ..write('firstReviewedAt: $firstReviewedAt, ')
          ..write('suspended: $suspended')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      noteId,
      deckId,
      templateId,
      ankiCardId,
      ordinal,
      state,
      due,
      stability,
      difficulty,
      reps,
      lapses,
      scheduledDays,
      learningSteps,
      lastReview,
      firstReviewedAt,
      suspended);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Card &&
          other.id == this.id &&
          other.noteId == this.noteId &&
          other.deckId == this.deckId &&
          other.templateId == this.templateId &&
          other.ankiCardId == this.ankiCardId &&
          other.ordinal == this.ordinal &&
          other.state == this.state &&
          other.due == this.due &&
          other.stability == this.stability &&
          other.difficulty == this.difficulty &&
          other.reps == this.reps &&
          other.lapses == this.lapses &&
          other.scheduledDays == this.scheduledDays &&
          other.learningSteps == this.learningSteps &&
          other.lastReview == this.lastReview &&
          other.firstReviewedAt == this.firstReviewedAt &&
          other.suspended == this.suspended);
}

class CardsCompanion extends UpdateCompanion<Card> {
  final Value<int> id;
  final Value<int> noteId;
  final Value<int> deckId;
  final Value<int> templateId;
  final Value<int?> ankiCardId;
  final Value<int> ordinal;
  final Value<String> state;
  final Value<DateTime> due;
  final Value<double?> stability;
  final Value<double?> difficulty;
  final Value<int> reps;
  final Value<int> lapses;
  final Value<int> scheduledDays;
  final Value<int> learningSteps;
  final Value<DateTime?> lastReview;
  final Value<DateTime?> firstReviewedAt;
  final Value<bool> suspended;
  const CardsCompanion({
    this.id = const Value.absent(),
    this.noteId = const Value.absent(),
    this.deckId = const Value.absent(),
    this.templateId = const Value.absent(),
    this.ankiCardId = const Value.absent(),
    this.ordinal = const Value.absent(),
    this.state = const Value.absent(),
    this.due = const Value.absent(),
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.reps = const Value.absent(),
    this.lapses = const Value.absent(),
    this.scheduledDays = const Value.absent(),
    this.learningSteps = const Value.absent(),
    this.lastReview = const Value.absent(),
    this.firstReviewedAt = const Value.absent(),
    this.suspended = const Value.absent(),
  });
  CardsCompanion.insert({
    this.id = const Value.absent(),
    required int noteId,
    required int deckId,
    required int templateId,
    this.ankiCardId = const Value.absent(),
    this.ordinal = const Value.absent(),
    this.state = const Value.absent(),
    required DateTime due,
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.reps = const Value.absent(),
    this.lapses = const Value.absent(),
    this.scheduledDays = const Value.absent(),
    this.learningSteps = const Value.absent(),
    this.lastReview = const Value.absent(),
    this.firstReviewedAt = const Value.absent(),
    this.suspended = const Value.absent(),
  })  : noteId = Value(noteId),
        deckId = Value(deckId),
        templateId = Value(templateId),
        due = Value(due);
  static Insertable<Card> custom({
    Expression<int>? id,
    Expression<int>? noteId,
    Expression<int>? deckId,
    Expression<int>? templateId,
    Expression<int>? ankiCardId,
    Expression<int>? ordinal,
    Expression<String>? state,
    Expression<DateTime>? due,
    Expression<double>? stability,
    Expression<double>? difficulty,
    Expression<int>? reps,
    Expression<int>? lapses,
    Expression<int>? scheduledDays,
    Expression<int>? learningSteps,
    Expression<DateTime>? lastReview,
    Expression<DateTime>? firstReviewedAt,
    Expression<bool>? suspended,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noteId != null) 'note_id': noteId,
      if (deckId != null) 'deck_id': deckId,
      if (templateId != null) 'template_id': templateId,
      if (ankiCardId != null) 'anki_card_id': ankiCardId,
      if (ordinal != null) 'ordinal': ordinal,
      if (state != null) 'state': state,
      if (due != null) 'due': due,
      if (stability != null) 'stability': stability,
      if (difficulty != null) 'difficulty': difficulty,
      if (reps != null) 'reps': reps,
      if (lapses != null) 'lapses': lapses,
      if (scheduledDays != null) 'scheduled_days': scheduledDays,
      if (learningSteps != null) 'learning_steps': learningSteps,
      if (lastReview != null) 'last_review': lastReview,
      if (firstReviewedAt != null) 'first_reviewed_at': firstReviewedAt,
      if (suspended != null) 'suspended': suspended,
    });
  }

  CardsCompanion copyWith(
      {Value<int>? id,
      Value<int>? noteId,
      Value<int>? deckId,
      Value<int>? templateId,
      Value<int?>? ankiCardId,
      Value<int>? ordinal,
      Value<String>? state,
      Value<DateTime>? due,
      Value<double?>? stability,
      Value<double?>? difficulty,
      Value<int>? reps,
      Value<int>? lapses,
      Value<int>? scheduledDays,
      Value<int>? learningSteps,
      Value<DateTime?>? lastReview,
      Value<DateTime?>? firstReviewedAt,
      Value<bool>? suspended}) {
    return CardsCompanion(
      id: id ?? this.id,
      noteId: noteId ?? this.noteId,
      deckId: deckId ?? this.deckId,
      templateId: templateId ?? this.templateId,
      ankiCardId: ankiCardId ?? this.ankiCardId,
      ordinal: ordinal ?? this.ordinal,
      state: state ?? this.state,
      due: due ?? this.due,
      stability: stability ?? this.stability,
      difficulty: difficulty ?? this.difficulty,
      reps: reps ?? this.reps,
      lapses: lapses ?? this.lapses,
      scheduledDays: scheduledDays ?? this.scheduledDays,
      learningSteps: learningSteps ?? this.learningSteps,
      lastReview: lastReview ?? this.lastReview,
      firstReviewedAt: firstReviewedAt ?? this.firstReviewedAt,
      suspended: suspended ?? this.suspended,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (noteId.present) {
      map['note_id'] = Variable<int>(noteId.value);
    }
    if (deckId.present) {
      map['deck_id'] = Variable<int>(deckId.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
    }
    if (ankiCardId.present) {
      map['anki_card_id'] = Variable<int>(ankiCardId.value);
    }
    if (ordinal.present) {
      map['ordinal'] = Variable<int>(ordinal.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (due.present) {
      map['due'] = Variable<DateTime>(due.value);
    }
    if (stability.present) {
      map['stability'] = Variable<double>(stability.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<double>(difficulty.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (lapses.present) {
      map['lapses'] = Variable<int>(lapses.value);
    }
    if (scheduledDays.present) {
      map['scheduled_days'] = Variable<int>(scheduledDays.value);
    }
    if (learningSteps.present) {
      map['learning_steps'] = Variable<int>(learningSteps.value);
    }
    if (lastReview.present) {
      map['last_review'] = Variable<DateTime>(lastReview.value);
    }
    if (firstReviewedAt.present) {
      map['first_reviewed_at'] = Variable<DateTime>(firstReviewedAt.value);
    }
    if (suspended.present) {
      map['suspended'] = Variable<bool>(suspended.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardsCompanion(')
          ..write('id: $id, ')
          ..write('noteId: $noteId, ')
          ..write('deckId: $deckId, ')
          ..write('templateId: $templateId, ')
          ..write('ankiCardId: $ankiCardId, ')
          ..write('ordinal: $ordinal, ')
          ..write('state: $state, ')
          ..write('due: $due, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty, ')
          ..write('reps: $reps, ')
          ..write('lapses: $lapses, ')
          ..write('scheduledDays: $scheduledDays, ')
          ..write('learningSteps: $learningSteps, ')
          ..write('lastReview: $lastReview, ')
          ..write('firstReviewedAt: $firstReviewedAt, ')
          ..write('suspended: $suspended')
          ..write(')'))
        .toString();
  }
}

class $ReviewsTable extends Reviews with TableInfo<$ReviewsTable, Review> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
      'card_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ratedAtMeta =
      const VerificationMeta('ratedAt');
  @override
  late final GeneratedColumn<DateTime> ratedAt = GeneratedColumn<DateTime>(
      'rated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
      'rating', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _elapsedDaysMeta =
      const VerificationMeta('elapsedDays');
  @override
  late final GeneratedColumn<int> elapsedDays = GeneratedColumn<int>(
      'elapsed_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _stabilityAfterMeta =
      const VerificationMeta('stabilityAfter');
  @override
  late final GeneratedColumn<double> stabilityAfter = GeneratedColumn<double>(
      'stability_after', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _durationMsMeta =
      const VerificationMeta('durationMs');
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
      'duration_ms', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, cardId, ratedAt, rating, elapsedDays, stabilityAfter, durationMs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reviews';
  @override
  VerificationContext validateIntegrity(Insertable<Review> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta,
          cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('rated_at')) {
      context.handle(_ratedAtMeta,
          ratedAt.isAcceptableOrUnknown(data['rated_at']!, _ratedAtMeta));
    } else if (isInserting) {
      context.missing(_ratedAtMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('elapsed_days')) {
      context.handle(
          _elapsedDaysMeta,
          elapsedDays.isAcceptableOrUnknown(
              data['elapsed_days']!, _elapsedDaysMeta));
    }
    if (data.containsKey('stability_after')) {
      context.handle(
          _stabilityAfterMeta,
          stabilityAfter.isAcceptableOrUnknown(
              data['stability_after']!, _stabilityAfterMeta));
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
          _durationMsMeta,
          durationMs.isAcceptableOrUnknown(
              data['duration_ms']!, _durationMsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Review map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Review(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cardId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}card_id'])!,
      ratedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}rated_at'])!,
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rating'])!,
      elapsedDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}elapsed_days'])!,
      stabilityAfter: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}stability_after']),
      durationMs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_ms'])!,
    );
  }

  @override
  $ReviewsTable createAlias(String alias) {
    return $ReviewsTable(attachedDatabase, alias);
  }
}

class Review extends DataClass implements Insertable<Review> {
  final int id;
  final int cardId;
  final DateTime ratedAt;
  final int rating;
  final int elapsedDays;
  final double? stabilityAfter;
  final int durationMs;
  const Review(
      {required this.id,
      required this.cardId,
      required this.ratedAt,
      required this.rating,
      required this.elapsedDays,
      this.stabilityAfter,
      required this.durationMs});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['card_id'] = Variable<int>(cardId);
    map['rated_at'] = Variable<DateTime>(ratedAt);
    map['rating'] = Variable<int>(rating);
    map['elapsed_days'] = Variable<int>(elapsedDays);
    if (!nullToAbsent || stabilityAfter != null) {
      map['stability_after'] = Variable<double>(stabilityAfter);
    }
    map['duration_ms'] = Variable<int>(durationMs);
    return map;
  }

  ReviewsCompanion toCompanion(bool nullToAbsent) {
    return ReviewsCompanion(
      id: Value(id),
      cardId: Value(cardId),
      ratedAt: Value(ratedAt),
      rating: Value(rating),
      elapsedDays: Value(elapsedDays),
      stabilityAfter: stabilityAfter == null && nullToAbsent
          ? const Value.absent()
          : Value(stabilityAfter),
      durationMs: Value(durationMs),
    );
  }

  factory Review.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Review(
      id: serializer.fromJson<int>(json['id']),
      cardId: serializer.fromJson<int>(json['cardId']),
      ratedAt: serializer.fromJson<DateTime>(json['ratedAt']),
      rating: serializer.fromJson<int>(json['rating']),
      elapsedDays: serializer.fromJson<int>(json['elapsedDays']),
      stabilityAfter: serializer.fromJson<double?>(json['stabilityAfter']),
      durationMs: serializer.fromJson<int>(json['durationMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cardId': serializer.toJson<int>(cardId),
      'ratedAt': serializer.toJson<DateTime>(ratedAt),
      'rating': serializer.toJson<int>(rating),
      'elapsedDays': serializer.toJson<int>(elapsedDays),
      'stabilityAfter': serializer.toJson<double?>(stabilityAfter),
      'durationMs': serializer.toJson<int>(durationMs),
    };
  }

  Review copyWith(
          {int? id,
          int? cardId,
          DateTime? ratedAt,
          int? rating,
          int? elapsedDays,
          Value<double?> stabilityAfter = const Value.absent(),
          int? durationMs}) =>
      Review(
        id: id ?? this.id,
        cardId: cardId ?? this.cardId,
        ratedAt: ratedAt ?? this.ratedAt,
        rating: rating ?? this.rating,
        elapsedDays: elapsedDays ?? this.elapsedDays,
        stabilityAfter:
            stabilityAfter.present ? stabilityAfter.value : this.stabilityAfter,
        durationMs: durationMs ?? this.durationMs,
      );
  Review copyWithCompanion(ReviewsCompanion data) {
    return Review(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      ratedAt: data.ratedAt.present ? data.ratedAt.value : this.ratedAt,
      rating: data.rating.present ? data.rating.value : this.rating,
      elapsedDays:
          data.elapsedDays.present ? data.elapsedDays.value : this.elapsedDays,
      stabilityAfter: data.stabilityAfter.present
          ? data.stabilityAfter.value
          : this.stabilityAfter,
      durationMs:
          data.durationMs.present ? data.durationMs.value : this.durationMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Review(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('ratedAt: $ratedAt, ')
          ..write('rating: $rating, ')
          ..write('elapsedDays: $elapsedDays, ')
          ..write('stabilityAfter: $stabilityAfter, ')
          ..write('durationMs: $durationMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, cardId, ratedAt, rating, elapsedDays, stabilityAfter, durationMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Review &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.ratedAt == this.ratedAt &&
          other.rating == this.rating &&
          other.elapsedDays == this.elapsedDays &&
          other.stabilityAfter == this.stabilityAfter &&
          other.durationMs == this.durationMs);
}

class ReviewsCompanion extends UpdateCompanion<Review> {
  final Value<int> id;
  final Value<int> cardId;
  final Value<DateTime> ratedAt;
  final Value<int> rating;
  final Value<int> elapsedDays;
  final Value<double?> stabilityAfter;
  final Value<int> durationMs;
  const ReviewsCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.ratedAt = const Value.absent(),
    this.rating = const Value.absent(),
    this.elapsedDays = const Value.absent(),
    this.stabilityAfter = const Value.absent(),
    this.durationMs = const Value.absent(),
  });
  ReviewsCompanion.insert({
    this.id = const Value.absent(),
    required int cardId,
    required DateTime ratedAt,
    required int rating,
    this.elapsedDays = const Value.absent(),
    this.stabilityAfter = const Value.absent(),
    this.durationMs = const Value.absent(),
  })  : cardId = Value(cardId),
        ratedAt = Value(ratedAt),
        rating = Value(rating);
  static Insertable<Review> custom({
    Expression<int>? id,
    Expression<int>? cardId,
    Expression<DateTime>? ratedAt,
    Expression<int>? rating,
    Expression<int>? elapsedDays,
    Expression<double>? stabilityAfter,
    Expression<int>? durationMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (ratedAt != null) 'rated_at': ratedAt,
      if (rating != null) 'rating': rating,
      if (elapsedDays != null) 'elapsed_days': elapsedDays,
      if (stabilityAfter != null) 'stability_after': stabilityAfter,
      if (durationMs != null) 'duration_ms': durationMs,
    });
  }

  ReviewsCompanion copyWith(
      {Value<int>? id,
      Value<int>? cardId,
      Value<DateTime>? ratedAt,
      Value<int>? rating,
      Value<int>? elapsedDays,
      Value<double?>? stabilityAfter,
      Value<int>? durationMs}) {
    return ReviewsCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      ratedAt: ratedAt ?? this.ratedAt,
      rating: rating ?? this.rating,
      elapsedDays: elapsedDays ?? this.elapsedDays,
      stabilityAfter: stabilityAfter ?? this.stabilityAfter,
      durationMs: durationMs ?? this.durationMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (ratedAt.present) {
      map['rated_at'] = Variable<DateTime>(ratedAt.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (elapsedDays.present) {
      map['elapsed_days'] = Variable<int>(elapsedDays.value);
    }
    if (stabilityAfter.present) {
      map['stability_after'] = Variable<double>(stabilityAfter.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewsCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('ratedAt: $ratedAt, ')
          ..write('rating: $rating, ')
          ..write('elapsedDays: $elapsedDays, ')
          ..write('stabilityAfter: $stabilityAfter, ')
          ..write('durationMs: $durationMs')
          ..write(')'))
        .toString();
  }
}

class $MediaTable extends Media with TableInfo<$MediaTable, MediaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _filenameMeta =
      const VerificationMeta('filename');
  @override
  late final GeneratedColumn<String> filename = GeneratedColumn<String>(
      'filename', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _checksumMeta =
      const VerificationMeta('checksum');
  @override
  late final GeneratedColumn<String> checksum = GeneratedColumn<String>(
      'checksum', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [id, filename, path, checksum];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media';
  @override
  VerificationContext validateIntegrity(Insertable<MediaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('filename')) {
      context.handle(_filenameMeta,
          filename.isAcceptableOrUnknown(data['filename']!, _filenameMeta));
    } else if (isInserting) {
      context.missing(_filenameMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('checksum')) {
      context.handle(_checksumMeta,
          checksum.isAcceptableOrUnknown(data['checksum']!, _checksumMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      filename: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}filename'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      checksum: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}checksum'])!,
    );
  }

  @override
  $MediaTable createAlias(String alias) {
    return $MediaTable(attachedDatabase, alias);
  }
}

class MediaData extends DataClass implements Insertable<MediaData> {
  final int id;
  final String filename;
  final String path;
  final String checksum;
  const MediaData(
      {required this.id,
      required this.filename,
      required this.path,
      required this.checksum});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['filename'] = Variable<String>(filename);
    map['path'] = Variable<String>(path);
    map['checksum'] = Variable<String>(checksum);
    return map;
  }

  MediaCompanion toCompanion(bool nullToAbsent) {
    return MediaCompanion(
      id: Value(id),
      filename: Value(filename),
      path: Value(path),
      checksum: Value(checksum),
    );
  }

  factory MediaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaData(
      id: serializer.fromJson<int>(json['id']),
      filename: serializer.fromJson<String>(json['filename']),
      path: serializer.fromJson<String>(json['path']),
      checksum: serializer.fromJson<String>(json['checksum']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'filename': serializer.toJson<String>(filename),
      'path': serializer.toJson<String>(path),
      'checksum': serializer.toJson<String>(checksum),
    };
  }

  MediaData copyWith(
          {int? id, String? filename, String? path, String? checksum}) =>
      MediaData(
        id: id ?? this.id,
        filename: filename ?? this.filename,
        path: path ?? this.path,
        checksum: checksum ?? this.checksum,
      );
  MediaData copyWithCompanion(MediaCompanion data) {
    return MediaData(
      id: data.id.present ? data.id.value : this.id,
      filename: data.filename.present ? data.filename.value : this.filename,
      path: data.path.present ? data.path.value : this.path,
      checksum: data.checksum.present ? data.checksum.value : this.checksum,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaData(')
          ..write('id: $id, ')
          ..write('filename: $filename, ')
          ..write('path: $path, ')
          ..write('checksum: $checksum')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, filename, path, checksum);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaData &&
          other.id == this.id &&
          other.filename == this.filename &&
          other.path == this.path &&
          other.checksum == this.checksum);
}

class MediaCompanion extends UpdateCompanion<MediaData> {
  final Value<int> id;
  final Value<String> filename;
  final Value<String> path;
  final Value<String> checksum;
  const MediaCompanion({
    this.id = const Value.absent(),
    this.filename = const Value.absent(),
    this.path = const Value.absent(),
    this.checksum = const Value.absent(),
  });
  MediaCompanion.insert({
    this.id = const Value.absent(),
    required String filename,
    required String path,
    this.checksum = const Value.absent(),
  })  : filename = Value(filename),
        path = Value(path);
  static Insertable<MediaData> custom({
    Expression<int>? id,
    Expression<String>? filename,
    Expression<String>? path,
    Expression<String>? checksum,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (filename != null) 'filename': filename,
      if (path != null) 'path': path,
      if (checksum != null) 'checksum': checksum,
    });
  }

  MediaCompanion copyWith(
      {Value<int>? id,
      Value<String>? filename,
      Value<String>? path,
      Value<String>? checksum}) {
    return MediaCompanion(
      id: id ?? this.id,
      filename: filename ?? this.filename,
      path: path ?? this.path,
      checksum: checksum ?? this.checksum,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (filename.present) {
      map['filename'] = Variable<String>(filename.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (checksum.present) {
      map['checksum'] = Variable<String>(checksum.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaCompanion(')
          ..write('id: $id, ')
          ..write('filename: $filename, ')
          ..write('path: $path, ')
          ..write('checksum: $checksum')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<Setting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String key;
  final String value;
  const Setting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory Setting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  Setting copyWith({String? key, String? value}) => Setting(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting && other.key == this.key && other.value == this.value);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<Setting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LumenDatabase extends GeneratedDatabase {
  _$LumenDatabase(QueryExecutor e) : super(e);
  $LumenDatabaseManager get managers => $LumenDatabaseManager(this);
  late final $DecksTable decks = $DecksTable(this);
  late final $NoteTypesTable noteTypes = $NoteTypesTable(this);
  late final $FieldsTable fields = $FieldsTable(this);
  late final $TemplatesTable templates = $TemplatesTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $NoteFieldsTable noteFields = $NoteFieldsTable(this);
  late final $CardsTable cards = $CardsTable(this);
  late final $ReviewsTable reviews = $ReviewsTable(this);
  late final $MediaTable media = $MediaTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        decks,
        noteTypes,
        fields,
        templates,
        notes,
        noteFields,
        cards,
        reviews,
        media,
        settings
      ];
}

typedef $$DecksTableCreateCompanionBuilder = DecksCompanion Function({
  Value<int> id,
  Value<int?> parentId,
  required String name,
  required String fullName,
  Value<int?> ankiDeckId,
  Value<int> newPerDay,
  Value<int> revPerDay,
  Value<bool> isFiltered,
});
typedef $$DecksTableUpdateCompanionBuilder = DecksCompanion Function({
  Value<int> id,
  Value<int?> parentId,
  Value<String> name,
  Value<String> fullName,
  Value<int?> ankiDeckId,
  Value<int> newPerDay,
  Value<int> revPerDay,
  Value<bool> isFiltered,
});

class $$DecksTableFilterComposer
    extends Composer<_$LumenDatabase, $DecksTable> {
  $$DecksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get parentId => $composableBuilder(
      column: $table.parentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ankiDeckId => $composableBuilder(
      column: $table.ankiDeckId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get newPerDay => $composableBuilder(
      column: $table.newPerDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get revPerDay => $composableBuilder(
      column: $table.revPerDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFiltered => $composableBuilder(
      column: $table.isFiltered, builder: (column) => ColumnFilters(column));
}

class $$DecksTableOrderingComposer
    extends Composer<_$LumenDatabase, $DecksTable> {
  $$DecksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get parentId => $composableBuilder(
      column: $table.parentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ankiDeckId => $composableBuilder(
      column: $table.ankiDeckId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get newPerDay => $composableBuilder(
      column: $table.newPerDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get revPerDay => $composableBuilder(
      column: $table.revPerDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFiltered => $composableBuilder(
      column: $table.isFiltered, builder: (column) => ColumnOrderings(column));
}

class $$DecksTableAnnotationComposer
    extends Composer<_$LumenDatabase, $DecksTable> {
  $$DecksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<int> get ankiDeckId => $composableBuilder(
      column: $table.ankiDeckId, builder: (column) => column);

  GeneratedColumn<int> get newPerDay =>
      $composableBuilder(column: $table.newPerDay, builder: (column) => column);

  GeneratedColumn<int> get revPerDay =>
      $composableBuilder(column: $table.revPerDay, builder: (column) => column);

  GeneratedColumn<bool> get isFiltered => $composableBuilder(
      column: $table.isFiltered, builder: (column) => column);
}

class $$DecksTableTableManager extends RootTableManager<
    _$LumenDatabase,
    $DecksTable,
    Deck,
    $$DecksTableFilterComposer,
    $$DecksTableOrderingComposer,
    $$DecksTableAnnotationComposer,
    $$DecksTableCreateCompanionBuilder,
    $$DecksTableUpdateCompanionBuilder,
    (Deck, BaseReferences<_$LumenDatabase, $DecksTable, Deck>),
    Deck,
    PrefetchHooks Function()> {
  $$DecksTableTableManager(_$LumenDatabase db, $DecksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DecksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DecksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DecksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> parentId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> fullName = const Value.absent(),
            Value<int?> ankiDeckId = const Value.absent(),
            Value<int> newPerDay = const Value.absent(),
            Value<int> revPerDay = const Value.absent(),
            Value<bool> isFiltered = const Value.absent(),
          }) =>
              DecksCompanion(
            id: id,
            parentId: parentId,
            name: name,
            fullName: fullName,
            ankiDeckId: ankiDeckId,
            newPerDay: newPerDay,
            revPerDay: revPerDay,
            isFiltered: isFiltered,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> parentId = const Value.absent(),
            required String name,
            required String fullName,
            Value<int?> ankiDeckId = const Value.absent(),
            Value<int> newPerDay = const Value.absent(),
            Value<int> revPerDay = const Value.absent(),
            Value<bool> isFiltered = const Value.absent(),
          }) =>
              DecksCompanion.insert(
            id: id,
            parentId: parentId,
            name: name,
            fullName: fullName,
            ankiDeckId: ankiDeckId,
            newPerDay: newPerDay,
            revPerDay: revPerDay,
            isFiltered: isFiltered,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DecksTableProcessedTableManager = ProcessedTableManager<
    _$LumenDatabase,
    $DecksTable,
    Deck,
    $$DecksTableFilterComposer,
    $$DecksTableOrderingComposer,
    $$DecksTableAnnotationComposer,
    $$DecksTableCreateCompanionBuilder,
    $$DecksTableUpdateCompanionBuilder,
    (Deck, BaseReferences<_$LumenDatabase, $DecksTable, Deck>),
    Deck,
    PrefetchHooks Function()>;
typedef $$NoteTypesTableCreateCompanionBuilder = NoteTypesCompanion Function({
  Value<int> id,
  required String name,
  Value<int?> ankiModelId,
  Value<String> css,
  Value<bool> isCloze,
});
typedef $$NoteTypesTableUpdateCompanionBuilder = NoteTypesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int?> ankiModelId,
  Value<String> css,
  Value<bool> isCloze,
});

class $$NoteTypesTableFilterComposer
    extends Composer<_$LumenDatabase, $NoteTypesTable> {
  $$NoteTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ankiModelId => $composableBuilder(
      column: $table.ankiModelId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get css => $composableBuilder(
      column: $table.css, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCloze => $composableBuilder(
      column: $table.isCloze, builder: (column) => ColumnFilters(column));
}

class $$NoteTypesTableOrderingComposer
    extends Composer<_$LumenDatabase, $NoteTypesTable> {
  $$NoteTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ankiModelId => $composableBuilder(
      column: $table.ankiModelId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get css => $composableBuilder(
      column: $table.css, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCloze => $composableBuilder(
      column: $table.isCloze, builder: (column) => ColumnOrderings(column));
}

class $$NoteTypesTableAnnotationComposer
    extends Composer<_$LumenDatabase, $NoteTypesTable> {
  $$NoteTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get ankiModelId => $composableBuilder(
      column: $table.ankiModelId, builder: (column) => column);

  GeneratedColumn<String> get css =>
      $composableBuilder(column: $table.css, builder: (column) => column);

  GeneratedColumn<bool> get isCloze =>
      $composableBuilder(column: $table.isCloze, builder: (column) => column);
}

class $$NoteTypesTableTableManager extends RootTableManager<
    _$LumenDatabase,
    $NoteTypesTable,
    NoteType,
    $$NoteTypesTableFilterComposer,
    $$NoteTypesTableOrderingComposer,
    $$NoteTypesTableAnnotationComposer,
    $$NoteTypesTableCreateCompanionBuilder,
    $$NoteTypesTableUpdateCompanionBuilder,
    (NoteType, BaseReferences<_$LumenDatabase, $NoteTypesTable, NoteType>),
    NoteType,
    PrefetchHooks Function()> {
  $$NoteTypesTableTableManager(_$LumenDatabase db, $NoteTypesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NoteTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NoteTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NoteTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int?> ankiModelId = const Value.absent(),
            Value<String> css = const Value.absent(),
            Value<bool> isCloze = const Value.absent(),
          }) =>
              NoteTypesCompanion(
            id: id,
            name: name,
            ankiModelId: ankiModelId,
            css: css,
            isCloze: isCloze,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<int?> ankiModelId = const Value.absent(),
            Value<String> css = const Value.absent(),
            Value<bool> isCloze = const Value.absent(),
          }) =>
              NoteTypesCompanion.insert(
            id: id,
            name: name,
            ankiModelId: ankiModelId,
            css: css,
            isCloze: isCloze,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NoteTypesTableProcessedTableManager = ProcessedTableManager<
    _$LumenDatabase,
    $NoteTypesTable,
    NoteType,
    $$NoteTypesTableFilterComposer,
    $$NoteTypesTableOrderingComposer,
    $$NoteTypesTableAnnotationComposer,
    $$NoteTypesTableCreateCompanionBuilder,
    $$NoteTypesTableUpdateCompanionBuilder,
    (NoteType, BaseReferences<_$LumenDatabase, $NoteTypesTable, NoteType>),
    NoteType,
    PrefetchHooks Function()>;
typedef $$FieldsTableCreateCompanionBuilder = FieldsCompanion Function({
  Value<int> id,
  required int noteTypeId,
  required String name,
  required int ordinal,
});
typedef $$FieldsTableUpdateCompanionBuilder = FieldsCompanion Function({
  Value<int> id,
  Value<int> noteTypeId,
  Value<String> name,
  Value<int> ordinal,
});

class $$FieldsTableFilterComposer
    extends Composer<_$LumenDatabase, $FieldsTable> {
  $$FieldsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get noteTypeId => $composableBuilder(
      column: $table.noteTypeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordinal => $composableBuilder(
      column: $table.ordinal, builder: (column) => ColumnFilters(column));
}

class $$FieldsTableOrderingComposer
    extends Composer<_$LumenDatabase, $FieldsTable> {
  $$FieldsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get noteTypeId => $composableBuilder(
      column: $table.noteTypeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordinal => $composableBuilder(
      column: $table.ordinal, builder: (column) => ColumnOrderings(column));
}

class $$FieldsTableAnnotationComposer
    extends Composer<_$LumenDatabase, $FieldsTable> {
  $$FieldsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get noteTypeId => $composableBuilder(
      column: $table.noteTypeId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get ordinal =>
      $composableBuilder(column: $table.ordinal, builder: (column) => column);
}

class $$FieldsTableTableManager extends RootTableManager<
    _$LumenDatabase,
    $FieldsTable,
    Field,
    $$FieldsTableFilterComposer,
    $$FieldsTableOrderingComposer,
    $$FieldsTableAnnotationComposer,
    $$FieldsTableCreateCompanionBuilder,
    $$FieldsTableUpdateCompanionBuilder,
    (Field, BaseReferences<_$LumenDatabase, $FieldsTable, Field>),
    Field,
    PrefetchHooks Function()> {
  $$FieldsTableTableManager(_$LumenDatabase db, $FieldsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FieldsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FieldsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FieldsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> noteTypeId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> ordinal = const Value.absent(),
          }) =>
              FieldsCompanion(
            id: id,
            noteTypeId: noteTypeId,
            name: name,
            ordinal: ordinal,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int noteTypeId,
            required String name,
            required int ordinal,
          }) =>
              FieldsCompanion.insert(
            id: id,
            noteTypeId: noteTypeId,
            name: name,
            ordinal: ordinal,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FieldsTableProcessedTableManager = ProcessedTableManager<
    _$LumenDatabase,
    $FieldsTable,
    Field,
    $$FieldsTableFilterComposer,
    $$FieldsTableOrderingComposer,
    $$FieldsTableAnnotationComposer,
    $$FieldsTableCreateCompanionBuilder,
    $$FieldsTableUpdateCompanionBuilder,
    (Field, BaseReferences<_$LumenDatabase, $FieldsTable, Field>),
    Field,
    PrefetchHooks Function()>;
typedef $$TemplatesTableCreateCompanionBuilder = TemplatesCompanion Function({
  Value<int> id,
  required int noteTypeId,
  required String name,
  required String frontHtml,
  required String backHtml,
  required int ordinal,
});
typedef $$TemplatesTableUpdateCompanionBuilder = TemplatesCompanion Function({
  Value<int> id,
  Value<int> noteTypeId,
  Value<String> name,
  Value<String> frontHtml,
  Value<String> backHtml,
  Value<int> ordinal,
});

class $$TemplatesTableFilterComposer
    extends Composer<_$LumenDatabase, $TemplatesTable> {
  $$TemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get noteTypeId => $composableBuilder(
      column: $table.noteTypeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frontHtml => $composableBuilder(
      column: $table.frontHtml, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get backHtml => $composableBuilder(
      column: $table.backHtml, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordinal => $composableBuilder(
      column: $table.ordinal, builder: (column) => ColumnFilters(column));
}

class $$TemplatesTableOrderingComposer
    extends Composer<_$LumenDatabase, $TemplatesTable> {
  $$TemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get noteTypeId => $composableBuilder(
      column: $table.noteTypeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frontHtml => $composableBuilder(
      column: $table.frontHtml, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get backHtml => $composableBuilder(
      column: $table.backHtml, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordinal => $composableBuilder(
      column: $table.ordinal, builder: (column) => ColumnOrderings(column));
}

class $$TemplatesTableAnnotationComposer
    extends Composer<_$LumenDatabase, $TemplatesTable> {
  $$TemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get noteTypeId => $composableBuilder(
      column: $table.noteTypeId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get frontHtml =>
      $composableBuilder(column: $table.frontHtml, builder: (column) => column);

  GeneratedColumn<String> get backHtml =>
      $composableBuilder(column: $table.backHtml, builder: (column) => column);

  GeneratedColumn<int> get ordinal =>
      $composableBuilder(column: $table.ordinal, builder: (column) => column);
}

class $$TemplatesTableTableManager extends RootTableManager<
    _$LumenDatabase,
    $TemplatesTable,
    Template,
    $$TemplatesTableFilterComposer,
    $$TemplatesTableOrderingComposer,
    $$TemplatesTableAnnotationComposer,
    $$TemplatesTableCreateCompanionBuilder,
    $$TemplatesTableUpdateCompanionBuilder,
    (Template, BaseReferences<_$LumenDatabase, $TemplatesTable, Template>),
    Template,
    PrefetchHooks Function()> {
  $$TemplatesTableTableManager(_$LumenDatabase db, $TemplatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> noteTypeId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> frontHtml = const Value.absent(),
            Value<String> backHtml = const Value.absent(),
            Value<int> ordinal = const Value.absent(),
          }) =>
              TemplatesCompanion(
            id: id,
            noteTypeId: noteTypeId,
            name: name,
            frontHtml: frontHtml,
            backHtml: backHtml,
            ordinal: ordinal,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int noteTypeId,
            required String name,
            required String frontHtml,
            required String backHtml,
            required int ordinal,
          }) =>
              TemplatesCompanion.insert(
            id: id,
            noteTypeId: noteTypeId,
            name: name,
            frontHtml: frontHtml,
            backHtml: backHtml,
            ordinal: ordinal,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TemplatesTableProcessedTableManager = ProcessedTableManager<
    _$LumenDatabase,
    $TemplatesTable,
    Template,
    $$TemplatesTableFilterComposer,
    $$TemplatesTableOrderingComposer,
    $$TemplatesTableAnnotationComposer,
    $$TemplatesTableCreateCompanionBuilder,
    $$TemplatesTableUpdateCompanionBuilder,
    (Template, BaseReferences<_$LumenDatabase, $TemplatesTable, Template>),
    Template,
    PrefetchHooks Function()>;
typedef $$NotesTableCreateCompanionBuilder = NotesCompanion Function({
  Value<int> id,
  required int noteTypeId,
  Value<int?> ankiNoteId,
  Value<String> tags,
  Value<DateTime> modifiedAt,
});
typedef $$NotesTableUpdateCompanionBuilder = NotesCompanion Function({
  Value<int> id,
  Value<int> noteTypeId,
  Value<int?> ankiNoteId,
  Value<String> tags,
  Value<DateTime> modifiedAt,
});

class $$NotesTableFilterComposer
    extends Composer<_$LumenDatabase, $NotesTable> {
  $$NotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get noteTypeId => $composableBuilder(
      column: $table.noteTypeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ankiNoteId => $composableBuilder(
      column: $table.ankiNoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnFilters(column));
}

class $$NotesTableOrderingComposer
    extends Composer<_$LumenDatabase, $NotesTable> {
  $$NotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get noteTypeId => $composableBuilder(
      column: $table.noteTypeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ankiNoteId => $composableBuilder(
      column: $table.ankiNoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnOrderings(column));
}

class $$NotesTableAnnotationComposer
    extends Composer<_$LumenDatabase, $NotesTable> {
  $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get noteTypeId => $composableBuilder(
      column: $table.noteTypeId, builder: (column) => column);

  GeneratedColumn<int> get ankiNoteId => $composableBuilder(
      column: $table.ankiNoteId, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => column);
}

class $$NotesTableTableManager extends RootTableManager<
    _$LumenDatabase,
    $NotesTable,
    Note,
    $$NotesTableFilterComposer,
    $$NotesTableOrderingComposer,
    $$NotesTableAnnotationComposer,
    $$NotesTableCreateCompanionBuilder,
    $$NotesTableUpdateCompanionBuilder,
    (Note, BaseReferences<_$LumenDatabase, $NotesTable, Note>),
    Note,
    PrefetchHooks Function()> {
  $$NotesTableTableManager(_$LumenDatabase db, $NotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> noteTypeId = const Value.absent(),
            Value<int?> ankiNoteId = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<DateTime> modifiedAt = const Value.absent(),
          }) =>
              NotesCompanion(
            id: id,
            noteTypeId: noteTypeId,
            ankiNoteId: ankiNoteId,
            tags: tags,
            modifiedAt: modifiedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int noteTypeId,
            Value<int?> ankiNoteId = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<DateTime> modifiedAt = const Value.absent(),
          }) =>
              NotesCompanion.insert(
            id: id,
            noteTypeId: noteTypeId,
            ankiNoteId: ankiNoteId,
            tags: tags,
            modifiedAt: modifiedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotesTableProcessedTableManager = ProcessedTableManager<
    _$LumenDatabase,
    $NotesTable,
    Note,
    $$NotesTableFilterComposer,
    $$NotesTableOrderingComposer,
    $$NotesTableAnnotationComposer,
    $$NotesTableCreateCompanionBuilder,
    $$NotesTableUpdateCompanionBuilder,
    (Note, BaseReferences<_$LumenDatabase, $NotesTable, Note>),
    Note,
    PrefetchHooks Function()>;
typedef $$NoteFieldsTableCreateCompanionBuilder = NoteFieldsCompanion Function({
  Value<int> id,
  required int noteId,
  required int fieldId,
  required String value,
});
typedef $$NoteFieldsTableUpdateCompanionBuilder = NoteFieldsCompanion Function({
  Value<int> id,
  Value<int> noteId,
  Value<int> fieldId,
  Value<String> value,
});

class $$NoteFieldsTableFilterComposer
    extends Composer<_$LumenDatabase, $NoteFieldsTable> {
  $$NoteFieldsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get noteId => $composableBuilder(
      column: $table.noteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fieldId => $composableBuilder(
      column: $table.fieldId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$NoteFieldsTableOrderingComposer
    extends Composer<_$LumenDatabase, $NoteFieldsTable> {
  $$NoteFieldsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get noteId => $composableBuilder(
      column: $table.noteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fieldId => $composableBuilder(
      column: $table.fieldId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$NoteFieldsTableAnnotationComposer
    extends Composer<_$LumenDatabase, $NoteFieldsTable> {
  $$NoteFieldsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get noteId =>
      $composableBuilder(column: $table.noteId, builder: (column) => column);

  GeneratedColumn<int> get fieldId =>
      $composableBuilder(column: $table.fieldId, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$NoteFieldsTableTableManager extends RootTableManager<
    _$LumenDatabase,
    $NoteFieldsTable,
    NoteField,
    $$NoteFieldsTableFilterComposer,
    $$NoteFieldsTableOrderingComposer,
    $$NoteFieldsTableAnnotationComposer,
    $$NoteFieldsTableCreateCompanionBuilder,
    $$NoteFieldsTableUpdateCompanionBuilder,
    (NoteField, BaseReferences<_$LumenDatabase, $NoteFieldsTable, NoteField>),
    NoteField,
    PrefetchHooks Function()> {
  $$NoteFieldsTableTableManager(_$LumenDatabase db, $NoteFieldsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NoteFieldsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NoteFieldsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NoteFieldsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> noteId = const Value.absent(),
            Value<int> fieldId = const Value.absent(),
            Value<String> value = const Value.absent(),
          }) =>
              NoteFieldsCompanion(
            id: id,
            noteId: noteId,
            fieldId: fieldId,
            value: value,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int noteId,
            required int fieldId,
            required String value,
          }) =>
              NoteFieldsCompanion.insert(
            id: id,
            noteId: noteId,
            fieldId: fieldId,
            value: value,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NoteFieldsTableProcessedTableManager = ProcessedTableManager<
    _$LumenDatabase,
    $NoteFieldsTable,
    NoteField,
    $$NoteFieldsTableFilterComposer,
    $$NoteFieldsTableOrderingComposer,
    $$NoteFieldsTableAnnotationComposer,
    $$NoteFieldsTableCreateCompanionBuilder,
    $$NoteFieldsTableUpdateCompanionBuilder,
    (NoteField, BaseReferences<_$LumenDatabase, $NoteFieldsTable, NoteField>),
    NoteField,
    PrefetchHooks Function()>;
typedef $$CardsTableCreateCompanionBuilder = CardsCompanion Function({
  Value<int> id,
  required int noteId,
  required int deckId,
  required int templateId,
  Value<int?> ankiCardId,
  Value<int> ordinal,
  Value<String> state,
  required DateTime due,
  Value<double?> stability,
  Value<double?> difficulty,
  Value<int> reps,
  Value<int> lapses,
  Value<int> scheduledDays,
  Value<int> learningSteps,
  Value<DateTime?> lastReview,
  Value<DateTime?> firstReviewedAt,
  Value<bool> suspended,
});
typedef $$CardsTableUpdateCompanionBuilder = CardsCompanion Function({
  Value<int> id,
  Value<int> noteId,
  Value<int> deckId,
  Value<int> templateId,
  Value<int?> ankiCardId,
  Value<int> ordinal,
  Value<String> state,
  Value<DateTime> due,
  Value<double?> stability,
  Value<double?> difficulty,
  Value<int> reps,
  Value<int> lapses,
  Value<int> scheduledDays,
  Value<int> learningSteps,
  Value<DateTime?> lastReview,
  Value<DateTime?> firstReviewedAt,
  Value<bool> suspended,
});

class $$CardsTableFilterComposer
    extends Composer<_$LumenDatabase, $CardsTable> {
  $$CardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get noteId => $composableBuilder(
      column: $table.noteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deckId => $composableBuilder(
      column: $table.deckId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get templateId => $composableBuilder(
      column: $table.templateId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ankiCardId => $composableBuilder(
      column: $table.ankiCardId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordinal => $composableBuilder(
      column: $table.ordinal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get due => $composableBuilder(
      column: $table.due, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get stability => $composableBuilder(
      column: $table.stability, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lapses => $composableBuilder(
      column: $table.lapses, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get scheduledDays => $composableBuilder(
      column: $table.scheduledDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get learningSteps => $composableBuilder(
      column: $table.learningSteps, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastReview => $composableBuilder(
      column: $table.lastReview, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get firstReviewedAt => $composableBuilder(
      column: $table.firstReviewedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get suspended => $composableBuilder(
      column: $table.suspended, builder: (column) => ColumnFilters(column));
}

class $$CardsTableOrderingComposer
    extends Composer<_$LumenDatabase, $CardsTable> {
  $$CardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get noteId => $composableBuilder(
      column: $table.noteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deckId => $composableBuilder(
      column: $table.deckId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get templateId => $composableBuilder(
      column: $table.templateId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ankiCardId => $composableBuilder(
      column: $table.ankiCardId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordinal => $composableBuilder(
      column: $table.ordinal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get due => $composableBuilder(
      column: $table.due, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get stability => $composableBuilder(
      column: $table.stability, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lapses => $composableBuilder(
      column: $table.lapses, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get scheduledDays => $composableBuilder(
      column: $table.scheduledDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get learningSteps => $composableBuilder(
      column: $table.learningSteps,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastReview => $composableBuilder(
      column: $table.lastReview, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get firstReviewedAt => $composableBuilder(
      column: $table.firstReviewedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get suspended => $composableBuilder(
      column: $table.suspended, builder: (column) => ColumnOrderings(column));
}

class $$CardsTableAnnotationComposer
    extends Composer<_$LumenDatabase, $CardsTable> {
  $$CardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get noteId =>
      $composableBuilder(column: $table.noteId, builder: (column) => column);

  GeneratedColumn<int> get deckId =>
      $composableBuilder(column: $table.deckId, builder: (column) => column);

  GeneratedColumn<int> get templateId => $composableBuilder(
      column: $table.templateId, builder: (column) => column);

  GeneratedColumn<int> get ankiCardId => $composableBuilder(
      column: $table.ankiCardId, builder: (column) => column);

  GeneratedColumn<int> get ordinal =>
      $composableBuilder(column: $table.ordinal, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<DateTime> get due =>
      $composableBuilder(column: $table.due, builder: (column) => column);

  GeneratedColumn<double> get stability =>
      $composableBuilder(column: $table.stability, builder: (column) => column);

  GeneratedColumn<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<int> get lapses =>
      $composableBuilder(column: $table.lapses, builder: (column) => column);

  GeneratedColumn<int> get scheduledDays => $composableBuilder(
      column: $table.scheduledDays, builder: (column) => column);

  GeneratedColumn<int> get learningSteps => $composableBuilder(
      column: $table.learningSteps, builder: (column) => column);

  GeneratedColumn<DateTime> get lastReview => $composableBuilder(
      column: $table.lastReview, builder: (column) => column);

  GeneratedColumn<DateTime> get firstReviewedAt => $composableBuilder(
      column: $table.firstReviewedAt, builder: (column) => column);

  GeneratedColumn<bool> get suspended =>
      $composableBuilder(column: $table.suspended, builder: (column) => column);
}

class $$CardsTableTableManager extends RootTableManager<
    _$LumenDatabase,
    $CardsTable,
    Card,
    $$CardsTableFilterComposer,
    $$CardsTableOrderingComposer,
    $$CardsTableAnnotationComposer,
    $$CardsTableCreateCompanionBuilder,
    $$CardsTableUpdateCompanionBuilder,
    (Card, BaseReferences<_$LumenDatabase, $CardsTable, Card>),
    Card,
    PrefetchHooks Function()> {
  $$CardsTableTableManager(_$LumenDatabase db, $CardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> noteId = const Value.absent(),
            Value<int> deckId = const Value.absent(),
            Value<int> templateId = const Value.absent(),
            Value<int?> ankiCardId = const Value.absent(),
            Value<int> ordinal = const Value.absent(),
            Value<String> state = const Value.absent(),
            Value<DateTime> due = const Value.absent(),
            Value<double?> stability = const Value.absent(),
            Value<double?> difficulty = const Value.absent(),
            Value<int> reps = const Value.absent(),
            Value<int> lapses = const Value.absent(),
            Value<int> scheduledDays = const Value.absent(),
            Value<int> learningSteps = const Value.absent(),
            Value<DateTime?> lastReview = const Value.absent(),
            Value<DateTime?> firstReviewedAt = const Value.absent(),
            Value<bool> suspended = const Value.absent(),
          }) =>
              CardsCompanion(
            id: id,
            noteId: noteId,
            deckId: deckId,
            templateId: templateId,
            ankiCardId: ankiCardId,
            ordinal: ordinal,
            state: state,
            due: due,
            stability: stability,
            difficulty: difficulty,
            reps: reps,
            lapses: lapses,
            scheduledDays: scheduledDays,
            learningSteps: learningSteps,
            lastReview: lastReview,
            firstReviewedAt: firstReviewedAt,
            suspended: suspended,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int noteId,
            required int deckId,
            required int templateId,
            Value<int?> ankiCardId = const Value.absent(),
            Value<int> ordinal = const Value.absent(),
            Value<String> state = const Value.absent(),
            required DateTime due,
            Value<double?> stability = const Value.absent(),
            Value<double?> difficulty = const Value.absent(),
            Value<int> reps = const Value.absent(),
            Value<int> lapses = const Value.absent(),
            Value<int> scheduledDays = const Value.absent(),
            Value<int> learningSteps = const Value.absent(),
            Value<DateTime?> lastReview = const Value.absent(),
            Value<DateTime?> firstReviewedAt = const Value.absent(),
            Value<bool> suspended = const Value.absent(),
          }) =>
              CardsCompanion.insert(
            id: id,
            noteId: noteId,
            deckId: deckId,
            templateId: templateId,
            ankiCardId: ankiCardId,
            ordinal: ordinal,
            state: state,
            due: due,
            stability: stability,
            difficulty: difficulty,
            reps: reps,
            lapses: lapses,
            scheduledDays: scheduledDays,
            learningSteps: learningSteps,
            lastReview: lastReview,
            firstReviewedAt: firstReviewedAt,
            suspended: suspended,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CardsTableProcessedTableManager = ProcessedTableManager<
    _$LumenDatabase,
    $CardsTable,
    Card,
    $$CardsTableFilterComposer,
    $$CardsTableOrderingComposer,
    $$CardsTableAnnotationComposer,
    $$CardsTableCreateCompanionBuilder,
    $$CardsTableUpdateCompanionBuilder,
    (Card, BaseReferences<_$LumenDatabase, $CardsTable, Card>),
    Card,
    PrefetchHooks Function()>;
typedef $$ReviewsTableCreateCompanionBuilder = ReviewsCompanion Function({
  Value<int> id,
  required int cardId,
  required DateTime ratedAt,
  required int rating,
  Value<int> elapsedDays,
  Value<double?> stabilityAfter,
  Value<int> durationMs,
});
typedef $$ReviewsTableUpdateCompanionBuilder = ReviewsCompanion Function({
  Value<int> id,
  Value<int> cardId,
  Value<DateTime> ratedAt,
  Value<int> rating,
  Value<int> elapsedDays,
  Value<double?> stabilityAfter,
  Value<int> durationMs,
});

class $$ReviewsTableFilterComposer
    extends Composer<_$LumenDatabase, $ReviewsTable> {
  $$ReviewsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cardId => $composableBuilder(
      column: $table.cardId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get ratedAt => $composableBuilder(
      column: $table.ratedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get elapsedDays => $composableBuilder(
      column: $table.elapsedDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get stabilityAfter => $composableBuilder(
      column: $table.stabilityAfter,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => ColumnFilters(column));
}

class $$ReviewsTableOrderingComposer
    extends Composer<_$LumenDatabase, $ReviewsTable> {
  $$ReviewsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cardId => $composableBuilder(
      column: $table.cardId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get ratedAt => $composableBuilder(
      column: $table.ratedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get elapsedDays => $composableBuilder(
      column: $table.elapsedDays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get stabilityAfter => $composableBuilder(
      column: $table.stabilityAfter,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => ColumnOrderings(column));
}

class $$ReviewsTableAnnotationComposer
    extends Composer<_$LumenDatabase, $ReviewsTable> {
  $$ReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get cardId =>
      $composableBuilder(column: $table.cardId, builder: (column) => column);

  GeneratedColumn<DateTime> get ratedAt =>
      $composableBuilder(column: $table.ratedAt, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<int> get elapsedDays => $composableBuilder(
      column: $table.elapsedDays, builder: (column) => column);

  GeneratedColumn<double> get stabilityAfter => $composableBuilder(
      column: $table.stabilityAfter, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => column);
}

class $$ReviewsTableTableManager extends RootTableManager<
    _$LumenDatabase,
    $ReviewsTable,
    Review,
    $$ReviewsTableFilterComposer,
    $$ReviewsTableOrderingComposer,
    $$ReviewsTableAnnotationComposer,
    $$ReviewsTableCreateCompanionBuilder,
    $$ReviewsTableUpdateCompanionBuilder,
    (Review, BaseReferences<_$LumenDatabase, $ReviewsTable, Review>),
    Review,
    PrefetchHooks Function()> {
  $$ReviewsTableTableManager(_$LumenDatabase db, $ReviewsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> cardId = const Value.absent(),
            Value<DateTime> ratedAt = const Value.absent(),
            Value<int> rating = const Value.absent(),
            Value<int> elapsedDays = const Value.absent(),
            Value<double?> stabilityAfter = const Value.absent(),
            Value<int> durationMs = const Value.absent(),
          }) =>
              ReviewsCompanion(
            id: id,
            cardId: cardId,
            ratedAt: ratedAt,
            rating: rating,
            elapsedDays: elapsedDays,
            stabilityAfter: stabilityAfter,
            durationMs: durationMs,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int cardId,
            required DateTime ratedAt,
            required int rating,
            Value<int> elapsedDays = const Value.absent(),
            Value<double?> stabilityAfter = const Value.absent(),
            Value<int> durationMs = const Value.absent(),
          }) =>
              ReviewsCompanion.insert(
            id: id,
            cardId: cardId,
            ratedAt: ratedAt,
            rating: rating,
            elapsedDays: elapsedDays,
            stabilityAfter: stabilityAfter,
            durationMs: durationMs,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ReviewsTableProcessedTableManager = ProcessedTableManager<
    _$LumenDatabase,
    $ReviewsTable,
    Review,
    $$ReviewsTableFilterComposer,
    $$ReviewsTableOrderingComposer,
    $$ReviewsTableAnnotationComposer,
    $$ReviewsTableCreateCompanionBuilder,
    $$ReviewsTableUpdateCompanionBuilder,
    (Review, BaseReferences<_$LumenDatabase, $ReviewsTable, Review>),
    Review,
    PrefetchHooks Function()>;
typedef $$MediaTableCreateCompanionBuilder = MediaCompanion Function({
  Value<int> id,
  required String filename,
  required String path,
  Value<String> checksum,
});
typedef $$MediaTableUpdateCompanionBuilder = MediaCompanion Function({
  Value<int> id,
  Value<String> filename,
  Value<String> path,
  Value<String> checksum,
});

class $$MediaTableFilterComposer
    extends Composer<_$LumenDatabase, $MediaTable> {
  $$MediaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get filename => $composableBuilder(
      column: $table.filename, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get checksum => $composableBuilder(
      column: $table.checksum, builder: (column) => ColumnFilters(column));
}

class $$MediaTableOrderingComposer
    extends Composer<_$LumenDatabase, $MediaTable> {
  $$MediaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get filename => $composableBuilder(
      column: $table.filename, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get checksum => $composableBuilder(
      column: $table.checksum, builder: (column) => ColumnOrderings(column));
}

class $$MediaTableAnnotationComposer
    extends Composer<_$LumenDatabase, $MediaTable> {
  $$MediaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get filename =>
      $composableBuilder(column: $table.filename, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<String> get checksum =>
      $composableBuilder(column: $table.checksum, builder: (column) => column);
}

class $$MediaTableTableManager extends RootTableManager<
    _$LumenDatabase,
    $MediaTable,
    MediaData,
    $$MediaTableFilterComposer,
    $$MediaTableOrderingComposer,
    $$MediaTableAnnotationComposer,
    $$MediaTableCreateCompanionBuilder,
    $$MediaTableUpdateCompanionBuilder,
    (MediaData, BaseReferences<_$LumenDatabase, $MediaTable, MediaData>),
    MediaData,
    PrefetchHooks Function()> {
  $$MediaTableTableManager(_$LumenDatabase db, $MediaTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> filename = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<String> checksum = const Value.absent(),
          }) =>
              MediaCompanion(
            id: id,
            filename: filename,
            path: path,
            checksum: checksum,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String filename,
            required String path,
            Value<String> checksum = const Value.absent(),
          }) =>
              MediaCompanion.insert(
            id: id,
            filename: filename,
            path: path,
            checksum: checksum,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MediaTableProcessedTableManager = ProcessedTableManager<
    _$LumenDatabase,
    $MediaTable,
    MediaData,
    $$MediaTableFilterComposer,
    $$MediaTableOrderingComposer,
    $$MediaTableAnnotationComposer,
    $$MediaTableCreateCompanionBuilder,
    $$MediaTableUpdateCompanionBuilder,
    (MediaData, BaseReferences<_$LumenDatabase, $MediaTable, MediaData>),
    MediaData,
    PrefetchHooks Function()>;
typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$SettingsTableFilterComposer
    extends Composer<_$LumenDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$SettingsTableOrderingComposer
    extends Composer<_$LumenDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$LumenDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SettingsTableTableManager extends RootTableManager<
    _$LumenDatabase,
    $SettingsTable,
    Setting,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableAnnotationComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (Setting, BaseReferences<_$LumenDatabase, $SettingsTable, Setting>),
    Setting,
    PrefetchHooks Function()> {
  $$SettingsTableTableManager(_$LumenDatabase db, $SettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SettingsTableProcessedTableManager = ProcessedTableManager<
    _$LumenDatabase,
    $SettingsTable,
    Setting,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableAnnotationComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (Setting, BaseReferences<_$LumenDatabase, $SettingsTable, Setting>),
    Setting,
    PrefetchHooks Function()>;

class $LumenDatabaseManager {
  final _$LumenDatabase _db;
  $LumenDatabaseManager(this._db);
  $$DecksTableTableManager get decks =>
      $$DecksTableTableManager(_db, _db.decks);
  $$NoteTypesTableTableManager get noteTypes =>
      $$NoteTypesTableTableManager(_db, _db.noteTypes);
  $$FieldsTableTableManager get fields =>
      $$FieldsTableTableManager(_db, _db.fields);
  $$TemplatesTableTableManager get templates =>
      $$TemplatesTableTableManager(_db, _db.templates);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
  $$NoteFieldsTableTableManager get noteFields =>
      $$NoteFieldsTableTableManager(_db, _db.noteFields);
  $$CardsTableTableManager get cards =>
      $$CardsTableTableManager(_db, _db.cards);
  $$ReviewsTableTableManager get reviews =>
      $$ReviewsTableTableManager(_db, _db.reviews);
  $$MediaTableTableManager get media =>
      $$MediaTableTableManager(_db, _db.media);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
