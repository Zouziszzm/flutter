import 'dart:io';

import 'package:drift/drift.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:path/path.dart' as p;

import '../core/template.dart';
import 'database.dart';

class DeckSummary {
  const DeckSummary({
    required this.deck,
    required this.due,
    required this.news,
    required this.total,
    required this.children,
  });

  final Deck deck;
  final int due;
  final int news;
  final int total;
  final List<DeckSummary> children;

  int get dueTree => due + children.fold(0, (a, c) => a + c.dueTree);
  int get newTree => news + children.fold(0, (a, c) => a + c.newTree);
  int get totalTree => total + children.fold(0, (a, c) => a + c.totalTree);
}

class StudyCard {
  const StudyCard({
    required this.card,
    required this.rendered,
    required this.deckName,
    required this.tags,
    required this.noteId,
  });

  final Card card;
  final RenderedCard rendered;
  final String deckName;
  final String tags;
  final int noteId;
}

class BrowseRow {
  const BrowseRow({
    required this.cardId,
    required this.noteId,
    required this.front,
    required this.back,
    required this.state,
    required this.due,
    required this.suspended,
    required this.tags,
  });

  final int cardId;
  final int noteId;
  final String front;
  final String back;
  final String state;
  final DateTime due;
  final bool suspended;
  final String tags;
}

class LumenRepository {
  LumenRepository(this.db);

  final LumenDatabase db;
  final _scheduler = fsrs.Scheduler();

  Stream<List<Deck>> watchDecks() {
    return (db.select(db.decks)..orderBy([(t) => OrderingTerm.asc(t.fullName)]))
        .watch();
  }

  Future<List<DeckSummary>> deckTree() async {
    final decks = await (db.select(db.decks)
          ..orderBy([(t) => OrderingTerm.asc(t.fullName)]))
        .get();
    final now = DateTime.now().toUtc();
    final summaries = <int, DeckSummary>{};

    for (final deck in decks) {
      final due = await _countDue(deck.id, now);
      final news = await _countNew(deck.id);
      final total = await (db.select(db.cards)
            ..where((c) => c.deckId.equals(deck.id) & c.suspended.equals(false)))
          .get()
          .then((r) => r.length);
      summaries[deck.id] = DeckSummary(
        deck: deck,
        due: due,
        news: news,
        total: total,
        children: [],
      );
    }

    final roots = <DeckSummary>[];
    for (final s in summaries.values) {
      final parent = s.deck.parentId;
      if (parent != null && summaries.containsKey(parent)) {
        summaries[parent]!.children.add(s);
      } else {
        roots.add(s);
      }
    }
    return roots;
  }

  Future<int> _countDue(int deckId, DateTime now) async {
    final rows = await (db.select(db.cards)
          ..where(
            (c) =>
                c.deckId.equals(deckId) &
                c.suspended.equals(false) &
                c.state.isNotValue('new') &
                c.due.isSmallerOrEqualValue(now),
          ))
        .get();
    return rows.length;
  }

  Future<int> _countNew(int deckId) async {
    final rows = await (db.select(db.cards)
          ..where(
            (c) =>
                c.deckId.equals(deckId) &
                c.suspended.equals(false) &
                c.state.equals('new'),
          ))
        .get();
    return rows.length;
  }

  Future<TodayCounts> todayCounts() async {
    final now = DateTime.now().toUtc();
    final due = await (db.select(db.cards)
          ..where(
            (c) =>
                c.suspended.equals(false) &
                c.state.isNotValue('new') &
                c.due.isSmallerOrEqualValue(now),
          ))
        .get();
    final news = await (db.select(db.cards)
          ..where((c) => c.suspended.equals(false) & c.state.equals('new')))
        .get();
    return TodayCounts(due: due.length, news: news.length);
  }

  Future<List<StudyCard>> loadQueue({int? deckId, int newLimit = 20}) async {
    final now = DateTime.now().toUtc();
    final deckIds = deckId == null ? null : await _deckAndDescendants(deckId);

    final reviewQuery = db.select(db.cards)
      ..where(
        (c) =>
            c.suspended.equals(false) &
            c.state.isNotValue('new') &
            c.due.isSmallerOrEqualValue(now),
      )
      ..orderBy([(c) => OrderingTerm.asc(c.due)])
      ..limit(80);
    if (deckIds != null) {
      reviewQuery.where((c) => c.deckId.isIn(deckIds));
    }

    final newQuery = db.select(db.cards)
      ..where((c) => c.suspended.equals(false) & c.state.equals('new'))
      ..orderBy([(c) => OrderingTerm.asc(c.id)])
      ..limit(newLimit);
    if (deckIds != null) {
      newQuery.where((c) => c.deckId.isIn(deckIds));
    }

    final reviews = await reviewQuery.get();
    final news = await newQuery.get();
    final mixed = <Card>[...news.take(newLimit), ...reviews];
    final mediaIndex = await _mediaIndex();
    final out = <StudyCard>[];
    for (final card in mixed) {
      final study = await _toStudy(card, mediaIndex: mediaIndex);
      if (study != null) out.add(study);
    }
    return out;
  }

  Future<List<int>> _deckAndDescendants(int id) async {
    final all = await db.select(db.decks).get();
    final ids = <int>{id};
    var changed = true;
    while (changed) {
      changed = false;
      for (final d in all) {
        if (d.parentId != null && ids.contains(d.parentId) && ids.add(d.id)) {
          changed = true;
        }
      }
    }
    return ids.toList();
  }

  Future<StudyCard?> _toStudy(Card card, {Map<String, String>? mediaIndex}) async {
    final note = await (db.select(db.notes)
          ..where((n) => n.id.equals(card.noteId)))
        .getSingleOrNull();
    if (note == null) return null;
    final type = await (db.select(db.noteTypes)
          ..where((t) => t.id.equals(note.noteTypeId)))
        .getSingle();
    final fields = await (db.select(db.fields)
          ..where((f) => f.noteTypeId.equals(type.id))
          ..orderBy([(f) => OrderingTerm.asc(f.ordinal)]))
        .get();
    final values = await (db.select(db.noteFields)
          ..where((v) => v.noteId.equals(note.id)))
        .get();
    final valueByField = {for (final v in values) v.fieldId: v.value};
    final fieldMap = <String, String>{
      for (final f in fields) f.name: valueByField[f.id] ?? '',
    };
    final tmpl = await (db.select(db.templates)
          ..where((t) => t.id.equals(card.templateId)))
        .getSingleOrNull();
    final deck = await (db.select(db.decks)
          ..where((d) => d.id.equals(card.deckId)))
        .getSingle();
    final rendered = renderCard(
      frontTemplate: tmpl?.frontHtml ?? '{{Front}}',
      backTemplate: tmpl?.backHtml ?? '{{Back}}',
      fields: fieldMap,
      cardOrd: card.ordinal,
      isCloze: type.isCloze || looksLikeCloze(fieldMap),
    );
    final index = mediaIndex ?? await _mediaIndex();
    return StudyCard(
      card: card,
      rendered: rendered.resolved((names) => _resolveMedia(names, index)),
      deckName: deck.fullName,
      tags: note.tags,
      noteId: note.id,
    );
  }

  Future<Map<String, String>> _mediaIndex() async {
    final rows = await db.select(db.media).get();
    final index = <String, String>{};
    for (final row in rows) {
      if (!File(row.path).existsSync()) continue;
      index[row.filename] = row.path;
      index[p.basename(row.filename)] = row.path;
      index[row.path] = row.path;
    }
    return index;
  }

  List<String> _resolveMedia(List<String> names, Map<String, String> index) {
    final out = <String>[];
    for (final raw in names) {
      final cleaned = raw.split('?').first.split('#').first;
      if (File(cleaned).existsSync()) {
        out.add(cleaned);
        continue;
      }
      final base = p.basename(cleaned);
      final path = index[cleaned] ?? index[base] ?? index[raw];
      if (path != null && File(path).existsSync()) {
        out.add(path);
      }
    }
    return out;
  }

  Future<StudyCard> rate(Card card, fsrs.Rating rating) async {
    final now = DateTime.now().toUtc();
    final fsrsCard = _toFsrs(card);
    final result = _scheduler.reviewCard(fsrsCard, rating, reviewDateTime: now);
    final next = result.card;
    final state = switch (next.state) {
      fsrs.State.learning => 'learning',
      fsrs.State.review => 'review',
      fsrs.State.relearning => 'relearning',
    };
    await (db.update(db.cards)..where((c) => c.id.equals(card.id))).write(
      CardsCompanion(
        state: Value(state),
        due: Value(next.due.toUtc()),
        stability: Value(next.stability),
        difficulty: Value(next.difficulty),
        reps: Value(card.reps + 1),
        lapses: Value(rating == fsrs.Rating.again ? card.lapses + 1 : card.lapses),
        scheduledDays: Value(next.due.toUtc().difference(now).inDays),
        learningSteps: Value(next.step ?? 0),
        lastReview: Value(now),
        firstReviewedAt: card.firstReviewedAt == null
            ? Value(now)
            : const Value.absent(),
      ),
    );
    await db.into(db.reviews).insert(
          ReviewsCompanion.insert(
            cardId: card.id,
            ratedAt: now,
            rating: rating.value,
            stabilityAfter: Value(next.stability),
          ),
        );
    final updated = await (db.select(db.cards)
          ..where((c) => c.id.equals(card.id)))
        .getSingle();
    return (await _toStudy(updated))!;
  }

  fsrs.Card _toFsrs(Card card) {
    return fsrs.Card(
      cardId: card.id,
      state: switch (card.state) {
        'learning' => fsrs.State.learning,
        'relearning' => fsrs.State.relearning,
        'review' => fsrs.State.review,
        _ => fsrs.State.learning,
      },
      due: card.due.toUtc(),
      stability: card.stability,
      difficulty: card.difficulty,
      step: card.learningSteps,
      lastReview: card.lastReview?.toUtc(),
    );
  }

  Map<fsrs.Rating, DateTime> previewIntervals(Card card) {
    final now = DateTime.now().toUtc();
    final current = _toFsrs(card);
    final out = <fsrs.Rating, DateTime>{};
    for (final rating in fsrs.Rating.values) {
      final next = _scheduler.reviewCard(
        current,
        rating,
        reviewDateTime: now,
      );
      out[rating] = next.card.due.toUtc();
    }
    return out;
  }

  Future<int> addBasicNote({
    required int deckId,
    required String front,
    required String back,
    String tags = '',
  }) async {
    final typeIdStr = await db.readSetting('default_note_type_id');
    var typeId = int.tryParse(typeIdStr ?? '');
    typeId ??= await _ensureBasicType();
    final fields = await (db.select(db.fields)
          ..where((f) => f.noteTypeId.equals(typeId!))
          ..orderBy([(f) => OrderingTerm.asc(f.ordinal)]))
        .get();
    final templates = await (db.select(db.templates)
          ..where((t) => t.noteTypeId.equals(typeId!)))
        .get();
    final noteId = await db.into(db.notes).insert(
          NotesCompanion.insert(noteTypeId: typeId, tags: Value(tags)),
        );
    for (final field in fields) {
      final value = field.ordinal == 0 ? front : (field.ordinal == 1 ? back : '');
      await db.into(db.noteFields).insert(
            NoteFieldsCompanion.insert(
              noteId: noteId,
              fieldId: field.id,
              value: value,
            ),
          );
    }
    final now = DateTime.now().toUtc();
    for (final tmpl in templates) {
      await db.into(db.cards).insert(
            CardsCompanion.insert(
              noteId: noteId,
              deckId: deckId,
              templateId: tmpl.id,
              due: now,
              ordinal: Value(tmpl.ordinal),
            ),
          );
    }
    return noteId;
  }

  Future<int> _ensureBasicType() async {
    final id = await db.into(db.noteTypes).insert(
          NoteTypesCompanion.insert(name: 'Basic'),
        );
    await db.into(db.fields).insert(
          FieldsCompanion.insert(noteTypeId: id, name: 'Front', ordinal: 0),
        );
    await db.into(db.fields).insert(
          FieldsCompanion.insert(noteTypeId: id, name: 'Back', ordinal: 1),
        );
    await db.into(db.templates).insert(
          TemplatesCompanion.insert(
            noteTypeId: id,
            name: 'Card 1',
            frontHtml: '{{Front}}',
            backHtml: '{{FrontSide}}<hr id=answer>{{Back}}',
            ordinal: 0,
          ),
        );
    await db.upsertSetting('default_note_type_id', '$id');
    return id;
  }

  Future<List<BrowseRow>> browse({int? deckId, String query = ''}) async {
    final cards = await (db.select(db.cards)
          ..where((c) => deckId == null ? const Constant(true) : c.deckId.equals(deckId))
          ..orderBy([(c) => OrderingTerm.desc(c.id)])
          ..limit(400))
        .get();
    final rows = <BrowseRow>[];
    final q = query.trim().toLowerCase();
    for (final card in cards) {
      final study = await _toStudy(card);
      if (study == null) continue;
      if (q.isNotEmpty &&
          !study.rendered.front.toLowerCase().contains(q) &&
          !study.rendered.back.toLowerCase().contains(q) &&
          !study.tags.toLowerCase().contains(q)) {
        continue;
      }
      rows.add(
        BrowseRow(
          cardId: card.id,
          noteId: card.noteId,
          front: study.rendered.front,
          back: study.rendered.back,
          state: card.state,
          due: card.due,
          suspended: card.suspended,
          tags: study.tags,
        ),
      );
    }
    return rows;
  }

  Future<void> setSuspended(int cardId, bool suspended) {
    return (db.update(db.cards)..where((c) => c.id.equals(cardId))).write(
      CardsCompanion(suspended: Value(suspended)),
    );
  }

  Future<Deck> createDeck(String name) async {
    final id = await db.into(db.decks).insert(
          DecksCompanion.insert(name: name, fullName: name),
        );
    return (db.select(db.decks)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<int> defaultDeckId() async {
    final raw = await db.readSetting('default_deck_id');
    final parsed = int.tryParse(raw ?? '');
    if (parsed != null) return parsed;
    final first = await db.select(db.decks).get();
    return first.first.id;
  }
}

class TodayCounts {
  const TodayCounts({required this.due, required this.news});
  final int due;
  final int news;
  int get total => due + news;
}
