import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository.dart';
import '../../providers.dart';
import '../../theme/lumen_theme.dart';
import '../../widgets/lumen_mark.dart';
import '../editor/add_note_sheet.dart';
import '../settings/settings_sheet.dart';

class LibraryPanel extends ConsumerWidget {
  const LibraryPanel({
    super.key,
    required this.onImport,
    this.compact = false,
  });

  final VoidCallback onImport;
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (compact) {
      return _MobileLibrary(
        onImport: onImport,
        onNewDeck: () => _newDeck(context, ref),
      );
    }

    final t = LumenTokens.of(context);
    final tree = ref.watch(deckTreeProvider);
    final today = ref.watch(todayProvider);
    final selection = ref.watch(selectionProvider);

    return ColoredBox(
      color: t.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, compact ? 16 : 20, 16, 8),
            child: Text(
              'LIBRARY',
              style: TextStyle(
                color: t.faint,
                fontSize: 11,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          today.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (c) => _Row(
              label: 'Today',
              count: c.total,
              selected: selection.mode != AppMode.browse &&
                  selection.deckId == null &&
                  selection.mode != AppMode.review,
              onTap: () {
                openOnMobile(ref, const Selection(), compact: compact);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 16, 6),
            child: Text(
              'DECKS',
              style: TextStyle(
                color: t.faint,
                fontSize: 11,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: tree.when(
              loading: () => const SizedBox.shrink(),
              error: (e, _) => Padding(
                padding: const EdgeInsets.all(20),
                child: Text('$e', style: TextStyle(color: t.muted)),
              ),
              data: (decks) {
                if (decks.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'No decks yet.',
                      style: TextStyle(color: t.muted, fontSize: 13),
                    ),
                  );
                }
                return ListView(
                  padding: const EdgeInsets.only(bottom: 16),
                  children: [
                    for (final node in decks) _DeckNode(node: node, depth: 0, compact: compact),
                  ],
                );
              },
            ),
          ),
          Divider(height: 1, color: t.border),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
            child: Column(
              children: [
                _FooterAction(label: 'Import Anki deck', onTap: onImport),
                _FooterAction(
                  label: 'Add card',
                  onTap: () => showAddNoteSheet(context, ref),
                ),
                _FooterAction(
                  label: 'New deck',
                  onTap: () => _newDeck(context, ref),
                ),
                _FooterAction(
                  label: 'Settings',
                  onTap: () => showSettingsSheet(context, ref),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _newDeck(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) {
        final t = LumenTokens.of(ctx);
        return AlertDialog(
          title: Text('New deck', style: TextStyle(color: t.text, fontSize: 16)),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Name'),
            onSubmitted: (v) => Navigator.pop(ctx, v),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Cancel', style: TextStyle(color: t.muted)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, controller.text),
              child: Text('Create', style: TextStyle(color: t.accent)),
            ),
          ],
        );
      },
    );
    if (name == null || name.trim().isEmpty) return;
    await ref.read(repositoryProvider).createDeck(name.trim());
    bumpLibrary(ref);
  }
}

class _MobileLibrary extends ConsumerWidget {
  const _MobileLibrary({required this.onImport, required this.onNewDeck});

  final VoidCallback onImport;
  final VoidCallback onNewDeck;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = LumenTokens.of(context);
    final tree = ref.watch(deckTreeProvider);
    final today = ref.watch(todayProvider);

    return ColoredBox(
      color: t.bg,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              children: [
                Row(
                  children: [
                    LumenMark(color: t.accent, size: 26),
                    const SizedBox(width: 10),
                    Text(
                      'Lumen',
                      style: TextStyle(
                        color: t.text,
                        fontSize: 34,
                        fontWeight: FontWeight.w400,
                        fontFamilyFallback: t.serifFamily,
                        height: 1.1,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Study with FSRS',
                  style: TextStyle(color: t.muted, fontSize: 15, height: 1.3),
                ),
                const SizedBox(height: 28),
                today.when(
                  loading: () => const SizedBox(height: 140),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (c) => _TodayHero(counts: c),
                ),
                const SizedBox(height: 28),
                Text(
                  'Decks',
                  style: TextStyle(
                    color: t.muted,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 10),
                tree.when(
                  loading: () => const SizedBox.shrink(),
                  error: (e, _) => Text('$e', style: TextStyle(color: t.muted)),
                  data: (decks) {
                    if (decks.isEmpty) {
                      return _EmptyDecks(onImport: onImport);
                    }
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: t.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: t.border),
                      ),
                      child: Column(
                        children: [
                          for (var i = 0; i < decks.length; i++) ...[
                            if (i > 0) Divider(height: 1, color: t.border),
                            _MobileDeckTile(node: decks[i]),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: t.surface,
              border: Border(top: BorderSide(color: t.border)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Row(
                  children: [
                    _BarAction(label: 'Import', onTap: onImport),
                    _BarAction(
                      label: 'Add card',
                      onTap: () => showAddNoteSheet(context, ref),
                    ),
                    _BarAction(label: 'New deck', onTap: onNewDeck),
                    _BarAction(
                      label: 'Settings',
                      onTap: () => showSettingsSheet(context, ref),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayHero extends ConsumerWidget {
  const _TodayHero({required this.counts});

  final TodayCounts counts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = LumenTokens.of(context);
    final empty = counts.total == 0;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: t.border),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: TextStyle(
                color: t.muted,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              empty ? 'Clear' : '${counts.total}',
              style: TextStyle(
                color: empty ? t.text : t.accent,
                fontSize: 52,
                height: 1.0,
                fontWeight: FontWeight.w400,
                fontFamilyFallback: t.serifFamily,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              empty
                  ? 'Nothing waiting. Import a deck or add a card.'
                  : '${counts.due} review · ${counts.news} new',
              style: TextStyle(color: t.muted, fontSize: 15, height: 1.35),
            ),
            if (!empty) ...[
              const SizedBox(height: 20),
              _FillButton(
                label: 'Study',
                onTap: () {
                  openOnMobile(
                    ref,
                    const Selection(mode: AppMode.review),
                    compact: true,
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _EmptyDecks extends StatelessWidget {
  const _EmptyDecks({required this.onImport});

  final VoidCallback onImport;

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: t.border),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No decks yet',
              style: TextStyle(
                color: t.text,
                fontSize: 17,
                fontFamilyFallback: t.serifFamily,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Import an Anki package to start studying.',
              style: TextStyle(color: t.muted, fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 16),
            _FillButton(label: 'Import deck', onTap: onImport),
          ],
        ),
      ),
    );
  }
}

class _MobileDeckTile extends ConsumerWidget {
  const _MobileDeckTile({required this.node});

  final DeckSummary node;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = LumenTokens.of(context);
    final due = node.dueTree + node.newTree;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          openOnMobile(
            ref,
            Selection(deckId: node.deck.id, mode: AppMode.today),
            compact: true,
          );
        },
        onLongPress: () {
          openOnMobile(
            ref,
            Selection(deckId: node.deck.id, mode: AppMode.browse),
            compact: true,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  node.deck.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: t.text,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              if (due > 0)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    '$due',
                    style: TextStyle(
                      color: t.accent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
              Icon(Icons.chevron_right, size: 20, color: t.faint),
            ],
          ),
        ),
      ),
    );
  }
}

class _FillButton extends StatelessWidget {
  const _FillButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: t.accent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: t.bg,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BarAction extends StatelessWidget {
  const _BarAction({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: t.muted,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    );
  }
}

class _DeckNode extends ConsumerWidget {
  const _DeckNode({required this.node, required this.depth, required this.compact});

  final DeckSummary node;
  final int depth;
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(selectionProvider);
    final selected = selection.deckId == node.deck.id;
    return Column(
      children: [
        _Row(
          label: node.deck.name,
          count: node.dueTree + node.newTree,
          selected: selected,
          indent: depth,
          onTap: () {
            openOnMobile(
              ref,
              Selection(deckId: node.deck.id, mode: AppMode.today),
              compact: compact,
            );
          },
          onStudy: (node.dueTree + node.newTree) > 0
              ? () {
                  openOnMobile(
                    ref,
                    Selection(deckId: node.deck.id, mode: AppMode.review),
                    compact: compact,
                  );
                }
              : null,
          onBrowse: () {
            openOnMobile(
              ref,
              Selection(deckId: node.deck.id, mode: AppMode.browse),
              compact: compact,
            );
          },
        ),
        for (final child in node.children)
          _DeckNode(node: child, depth: depth + 1, compact: compact),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
    this.indent = 0,
    this.onStudy,
    this.onBrowse,
  });

  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;
  final int indent;
  final VoidCallback? onStudy;
  final VoidCallback? onBrowse;

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        onSecondaryTap: onBrowse,
        child: Container(
          color: selected ? t.accent.withValues(alpha: 0.10) : Colors.transparent,
          padding: EdgeInsets.fromLTRB(16.0 + indent * 14, 8, 16, 8),
          child: Row(
            children: [
              if (selected)
                Container(
                  width: 2,
                  height: 14,
                  margin: const EdgeInsets.only(right: 10),
                  color: t.accent,
                )
              else
                const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected ? t.text : t.muted,
                    fontSize: 13.5,
                    fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ),
              if (onStudy != null)
                GestureDetector(
                  onTap: onStudy,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      'Study',
                      style: TextStyle(color: t.accent, fontSize: 11),
                    ),
                  ),
                ),
              Text(
                count == 0 ? '' : '$count',
                style: TextStyle(
                  color: count > 0 ? t.accent : t.faint,
                  fontSize: 12,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterAction extends StatelessWidget {
  const _FooterAction({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: TextStyle(color: t.muted, fontSize: 13),
            ),
          ),
        ),
      ),
    );
  }
}
