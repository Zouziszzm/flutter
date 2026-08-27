import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/database.dart';
import 'data/media_store.dart';
import 'data/repository.dart';
import 'import/apkg_importer.dart';

final databaseProvider = Provider<LumenDatabase>((ref) {
  final db = LumenDatabase();
  ref.onDispose(db.close);
  return db;
});

final mediaStoreProvider = Provider<MediaStore>((ref) => MediaStore());

final repositoryProvider = Provider<LumenRepository>((ref) {
  return LumenRepository(ref.watch(databaseProvider));
});

final importerProvider = Provider<ApkgImporter>((ref) {
  return ApkgImporter(
    db: ref.watch(databaseProvider),
    mediaStore: ref.watch(mediaStoreProvider),
  );
});

final themeModeProvider = StateNotifierProvider<ThemeModeController, ThemeMode>(
  (ref) => ThemeModeController(ref),
);

class ThemeModeController extends StateNotifier<ThemeMode> {
  ThemeModeController(this.ref) : super(ThemeMode.system) {
    _load();
  }

  final Ref ref;

  Future<void> _load() async {
    final raw = await ref.read(databaseProvider).readSetting('theme');
    state = switch (raw) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> setMode(ThemeMode mode) async {
    state = mode;
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await ref.read(databaseProvider).upsertSetting('theme', value);
  }
}

final libraryTickProvider = StateProvider<int>((ref) => 0);

void bumpLibrary(dynamic ref) {
  ref.read(libraryTickProvider.notifier).state++;
}

final deckTreeProvider = FutureProvider<List<DeckSummary>>((ref) async {
  ref.watch(libraryTickProvider);
  return ref.watch(repositoryProvider).deckTree();
});

final todayProvider = FutureProvider<TodayCounts>((ref) async {
  ref.watch(libraryTickProvider);
  return ref.watch(repositoryProvider).todayCounts();
});

class Selection {
  const Selection({this.deckId, this.mode = AppMode.today});

  final int? deckId;
  final AppMode mode;

  Selection copyWith({int? deckId, AppMode? mode, bool clearDeck = false}) {
    return Selection(
      deckId: clearDeck ? null : (deckId ?? this.deckId),
      mode: mode ?? this.mode,
    );
  }
}

enum AppMode { today, review, browse }

final selectionProvider = StateProvider<Selection>((ref) => const Selection());

/// On phones, the library is the root. Opening Today / a deck pushes a page.
final mobileOpenProvider = StateProvider<bool>((ref) => false);

void openOnMobile(dynamic ref, Selection selection, {required bool compact}) {
  ref.read(selectionProvider.notifier).state = selection;
  if (compact) {
    ref.read(mobileOpenProvider.notifier).state = true;
  }
}

void closeMobilePage(dynamic ref) {
  final selection = ref.read(selectionProvider);
  if (selection.mode == AppMode.review || selection.mode == AppMode.browse) {
    ref.read(selectionProvider.notifier).state =
        selection.copyWith(mode: AppMode.today);
    return;
  }
  ref.read(mobileOpenProvider.notifier).state = false;
}
