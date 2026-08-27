import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../providers.dart';
import '../../theme/lumen_theme.dart';
import '../browser/browser_panel.dart';
import '../editor/add_note_sheet.dart';
import '../importer/import_sheet.dart';
import '../library/library_panel.dart';
import '../review/review_panel.dart';
import '../settings/settings_sheet.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> with WidgetsBindingObserver {
  bool _dragging = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _importInboxPackages());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _importInboxPackages();
    }
  }

  bool _isAnkiPackage(String name) {
    final lower = name.toLowerCase();
    return lower.endsWith('.apkg') || lower.endsWith('.colpkg');
  }

  Future<void> _importInboxPackages() async {
    try {
      final docs = await getApplicationDocumentsDirectory();
      final inbox = Directory(p.join(docs.path, 'Inbox'));
      if (!inbox.existsSync()) return;
      final files = inbox
          .listSync()
          .whereType<File>()
          .where((f) => _isAnkiPackage(f.path))
          .toList();
      for (final file in files) {
        if (!mounted) return;
        await showImportSheet(context, ref, file.path);
        if (file.existsSync()) {
          file.deleteSync();
        }
      }
    } catch (_) {}
  }

  Future<void> _showImportMessage(String message, {bool error = true}) async {
    if (!mounted) return;
    final t = LumenTokens.of(context);
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          error ? 'Import' : 'Lumen',
          style: TextStyle(
            color: t.text,
            fontSize: 18,
            fontFamilyFallback: t.serifFamily,
          ),
        ),
        content: Text(message, style: TextStyle(color: t.muted, height: 1.45)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('OK', style: TextStyle(color: t.accent)),
          ),
        ],
      ),
    );
  }

  Future<String?> _localCopy(PlatformFile picked) async {
    final name = picked.name;
    final dest = File(
      p.join(Directory.systemTemp.path, 'lumen_${DateTime.now().millisecondsSinceEpoch}_$name'),
    );
    if (picked.path != null) {
      final source = File(picked.path!);
      if (source.existsSync()) {
        await source.copy(dest.path);
        return dest.path;
      }
    }
    if (picked.bytes != null && picked.bytes!.isNotEmpty) {
      await dest.writeAsBytes(picked.bytes!, flush: true);
      return dest.path;
    }
    return null;
  }

  Future<void> _importPath(String path, {String? displayName}) async {
    final name = displayName ?? p.basename(path);
    if (!_isAnkiPackage(name) && !_isAnkiPackage(path)) {
      await _showImportMessage('Choose an Anki package (.apkg or .colpkg).');
      return;
    }
    if (!mounted) return;
    await showImportSheet(context, ref, path);
  }

  Future<void> _pickImport() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: Platform.isIOS ? FileType.any : FileType.custom,
        allowedExtensions: Platform.isIOS ? null : const ['apkg', 'colpkg'],
        withData: Platform.isIOS,
      );
      if (result == null || result.files.isEmpty) return;
      final picked = result.files.single;
      if (!_isAnkiPackage(picked.name)) {
        await _showImportMessage('That file is not an Anki package. Pick a .apkg or .colpkg.');
        return;
      }
      final local = await _localCopy(picked);
      if (local == null) {
        await _showImportMessage('Could not read that file. Try Files → Browse, then pick the .apkg again.');
        return;
      }
      await _importPath(local, displayName: picked.name);
    } on PlatformException catch (e) {
      await _showImportMessage(e.message ?? '$e');
    } catch (e) {
      await _showImportMessage('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    final selection = ref.watch(selectionProvider);
    final wide = MediaQuery.sizeOf(context).width >= 860;

    final body = CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyI, meta: true): _pickImport,
        const SingleActivator(LogicalKeyboardKey.keyN, meta: true): () {
          showAddNoteSheet(context, ref);
        },
        const SingleActivator(LogicalKeyboardKey.comma, meta: true): () {
          showSettingsSheet(context, ref);
        },
        const SingleActivator(LogicalKeyboardKey.escape): () {
          ref.read(selectionProvider.notifier).state =
              selection.copyWith(mode: AppMode.today);
        },
      },
      child: Focus(
        autofocus: true,
        child: wide ? _desktop(t, selection) : _mobile(t, selection),
      ),
    );

    if (!Platform.isMacOS && !Platform.isWindows && !Platform.isLinux) {
      return body;
    }

    return DropTarget(
      onDragEntered: (_) => setState(() => _dragging = true),
      onDragExited: (_) => setState(() => _dragging = false),
      onDragDone: (detail) async {
        setState(() => _dragging = false);
        for (final file in detail.files) {
          await _importPath(file.path);
        }
      },
      child: Stack(
        children: [
          body,
          if (_dragging)
            Positioned.fill(
              child: ColoredBox(
                color: t.bg.withValues(alpha: 0.72),
                child: Center(
                  child: Text(
                    'Drop an Anki package to import',
                    style: TextStyle(
                      color: t.accent,
                      fontSize: 18,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _desktop(LumenTokens t, Selection selection) {
    return ColoredBox(
      color: t.bg,
      child: Column(
        children: [
          const _TitleBar(),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 268,
                  child: LibraryPanel(onImport: _pickImport),
                ),
                VerticalDivider(width: 1, color: t.border),
                Expanded(child: _main(selection)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mobile(LumenTokens t, Selection selection) {
    if (selection.mode == AppMode.review) {
      return const ReviewPanel();
    }
    final opened = ref.watch(mobileOpenProvider);
    if (opened) {
      return ColoredBox(
        color: t.bg,
        child: Column(
          children: [
            SafeArea(
              bottom: false,
              child: _MobileBar(
                title: selection.mode == AppMode.browse
                    ? 'Browse'
                    : (selection.deckId == null ? 'Today' : 'Deck'),
                onBack: () => closeMobilePage(ref),
              ),
            ),
            Expanded(child: _main(selection)),
          ],
        ),
      );
    }
    return ColoredBox(
      color: t.bg,
      child: SafeArea(
        bottom: false,
        child: LibraryPanel(onImport: _pickImport, compact: true),
      ),
    );
  }

  Widget _main(Selection selection) {
    return switch (selection.mode) {
      AppMode.review => const ReviewPanel(),
      AppMode.browse => const BrowserPanel(),
      AppMode.today => const _TodayPane(),
    };
  }
}

class _TitleBar extends StatelessWidget {
  const _TitleBar();

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: t.bg,
          border: Border(bottom: BorderSide(color: t.border)),
        ),
        padding: const EdgeInsets.only(left: 78, right: 16),
        alignment: Alignment.centerLeft,
        child: Text(
          'Lumen',
          style: TextStyle(
            color: t.muted,
            fontSize: 12,
            letterSpacing: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _MobileBar extends StatelessWidget {
  const _MobileBar({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 20, 8),
      child: SizedBox(
        height: 44,
        child: Row(
          children: [
            GestureDetector(
              onTap: onBack,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    Icon(Icons.chevron_left, size: 28, color: t.accent),
                    Text(
                      'Library',
                      style: TextStyle(
                        color: t.accent,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: t.text,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 88),
          ],
        ),
      ),
    );
  }
}

class _TodayPane extends ConsumerWidget {
  const _TodayPane();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = LumenTokens.of(context);
    final today = ref.watch(todayProvider);
    final selection = ref.watch(selectionProvider);

    return ColoredBox(
      color: t.bg,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: today.when(
            loading: () => Text('Loading', style: TextStyle(color: t.muted)),
            error: (e, _) => Text('$e', style: TextStyle(color: t.muted)),
            data: (counts) {
              final empty = counts.total == 0;
              final phone = LumenTokens.phone(context);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: phone ? 24 : 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      empty ? 'Nothing due' : 'Ready to study',
                      style: TextStyle(
                        color: t.text,
                        fontSize: phone ? 34 : 28,
                        fontWeight: FontWeight.w400,
                        fontFamilyFallback: t.serifFamily,
                        height: 1.15,
                        letterSpacing: phone ? -0.4 : 0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      empty
                          ? 'Import an Anki deck or add a card to begin.'
                          : '${counts.due} review · ${counts.news} new',
                      style: TextStyle(color: t.muted, fontSize: phone ? 16 : 14, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    if (!empty)
                      LumenStudyButton(
                        label: selection.deckId == null
                            ? 'Study today'
                            : 'Study this deck',
                        wide: phone,
                        onTap: () {
                          ref.read(selectionProvider.notifier).state =
                              selection.copyWith(mode: AppMode.review);
                        },
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class LumenStudyButton extends StatelessWidget {
  const LumenStudyButton({
    super.key,
    required this.label,
    required this.onTap,
    this.wide = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: t.accent,
            borderRadius: BorderRadius.circular(wide ? 12 : 8),
          ),
          child: SizedBox(
            width: wide ? double.infinity : null,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: wide ? 22 : 22,
                vertical: wide ? 16 : 12,
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: t.bg,
                  fontSize: wide ? 16 : 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
