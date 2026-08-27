import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:intl/intl.dart';

import '../../data/repository.dart';
import '../../providers.dart';
import '../../theme/lumen_theme.dart';
import '../../widgets/card_av.dart';
import '../../widgets/lumen_button.dart';

final _sessionProvider =
    StateNotifierProvider.autoDispose<ReviewSession, ReviewState>((ref) {
  return ReviewSession(ref);
});

class ReviewState {
  const ReviewState({
    this.queue = const [],
    this.index = 0,
    this.revealed = false,
    this.done = 0,
    this.loading = true,
    this.error,
  });

  final List<StudyCard> queue;
  final int index;
  final bool revealed;
  final int done;
  final bool loading;
  final String? error;

  StudyCard? get current =>
      index < queue.length ? queue[index] : null;

  int get remaining => queue.length - index;

  ReviewState copyWith({
    List<StudyCard>? queue,
    int? index,
    bool? revealed,
    int? done,
    bool? loading,
    String? error,
  }) {
    return ReviewState(
      queue: queue ?? this.queue,
      index: index ?? this.index,
      revealed: revealed ?? this.revealed,
      done: done ?? this.done,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}

class ReviewSession extends StateNotifier<ReviewState> {
  ReviewSession(this.ref) : super(const ReviewState()) {
    _load();
  }

  final Ref ref;

  Future<void> _load() async {
    try {
      final selection = ref.read(selectionProvider);
      final repo = ref.read(repositoryProvider);
      final newLimit = int.tryParse(
            await ref.read(databaseProvider).readSetting('new_per_day') ?? '20',
          ) ??
          20;
      final queue = await repo.loadQueue(
        deckId: selection.deckId,
        newLimit: newLimit,
      );
      state = ReviewState(queue: queue, loading: false);
    } catch (e) {
      state = ReviewState(loading: false, error: '$e');
    }
  }

  void reveal() {
    if (state.current == null) return;
    HapticFeedback.selectionClick();
    state = state.copyWith(revealed: true);
  }

  Future<void> rate(fsrs.Rating rating) async {
    final current = state.current;
    if (current == null) return;
    if (!state.revealed) {
      reveal();
      return;
    }
    await HapticFeedback.lightImpact();
    await ref.read(repositoryProvider).rate(current.card, rating);
    final next = state.index + 1;
    state = state.copyWith(
      index: next,
      revealed: false,
      done: state.done + 1,
    );
    if (next >= state.queue.length) {
      bumpLibrary(ref);
    }
  }
}

class ReviewPanel extends ConsumerWidget {
  const ReviewPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = LumenTokens.of(context);
    final session = ref.watch(_sessionProvider);
    final notifier = ref.read(_sessionProvider.notifier);

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.space): notifier.reveal,
        const SingleActivator(LogicalKeyboardKey.digit1): () =>
            notifier.rate(fsrs.Rating.again),
        const SingleActivator(LogicalKeyboardKey.digit2): () =>
            notifier.rate(fsrs.Rating.hard),
        const SingleActivator(LogicalKeyboardKey.digit3): () =>
            notifier.rate(fsrs.Rating.good),
        const SingleActivator(LogicalKeyboardKey.digit4): () =>
            notifier.rate(fsrs.Rating.easy),
        const SingleActivator(LogicalKeyboardKey.escape): () {
          bumpLibrary(ref);
          closeMobilePage(ref);
        },
      },
      child: Focus(
        autofocus: true,
        child: ColoredBox(
          color: t.bg,
          child: SafeArea(
            child: session.loading
                ? Center(child: Text('Preparing', style: TextStyle(color: t.muted)))
                : session.error != null
                    ? Center(child: Text(session.error!, style: TextStyle(color: t.muted)))
                    : session.current == null
                        ? _Finished(done: session.done)
                        : _CardStage(state: session),
          ),
        ),
      ),
    );
  }
}

class _Finished extends ConsumerWidget {
  const _Finished({required this.done});

  final int done;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = LumenTokens.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              done == 0 ? 'No cards due' : 'Session complete',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: t.text,
                fontSize: 32,
                height: 1.15,
                letterSpacing: -0.4,
                fontFamilyFallback: t.serifFamily,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              done == 0 ? 'Come back later.' : '$done reviewed',
              style: TextStyle(color: t.muted, fontSize: 16),
            ),
            const SizedBox(height: 32),
            LumenButton(
              label: 'Back to library',
              primary: true,
              expanded: LumenTokens.phone(context),
              onTap: () {
                bumpLibrary(ref);
                ref.read(selectionProvider.notifier).state = const Selection();
                ref.read(mobileOpenProvider.notifier).state = false;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CardStage extends ConsumerWidget {
  const _CardStage({required this.state});

  final ReviewState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = LumenTokens.of(context);
    final card = state.current!;
    final repo = ref.watch(repositoryProvider);
    final intervals = state.revealed ? repo.previewIntervals(card.card) : null;

    final phone = LumenTokens.phone(context);
    final ios = Platform.isIOS;
    final hPad = phone ? 20.0 : 36.0;

    if (phone) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 6, 20, 0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    bumpLibrary(ref);
                    closeMobilePage(ref);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
                    child: Row(
                      children: [
                        Icon(Icons.chevron_left, size: 28, color: t.accent),
                        Text(
                          'Close',
                          style: TextStyle(color: t.accent, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    card.deckName,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: t.muted,
                      fontSize: 13,
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '${state.remaining}',
                  style: TextStyle(
                    color: t.faint,
                    fontSize: 13,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _CardFace(
                          card: card,
                          revealed: state.revealed,
                          compact: true,
                          dividerColor: t.border,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (state.revealed)
            _RatingRow(
              intervals: intervals,
              compact: true,
              showShortcut: false,
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: GestureDetector(
                onTap: () => ref.read(_sessionProvider.notifier).reveal(),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: t.accent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Show answer',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF0E0E0C),
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    }

    final cardPad = 48.0;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 10, 28, 0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  card.deckName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: t.muted, fontSize: 12, letterSpacing: 0.3),
                ),
              ),
              Text(
                '${state.done + 1}  ·  ${state.remaining} left',
                style: TextStyle(
                  color: t.faint,
                  fontSize: 12,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 48,
                    maxWidth: 720,
                  ),
                  child: Center(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: t.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: t.border),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(cardPad, cardPad, cardPad, 40),
                        child: _CardFace(
                          card: card,
                          revealed: state.revealed,
                          compact: false,
                          dividerColor: t.border,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 28),
          child: state.revealed
              ? _RatingRow(
                  intervals: intervals,
                  compact: false,
                  showShortcut: !ios,
                )
              : Center(
                  child: LumenButton(
                    label: 'Show answer',
                    shortcut: 'Space',
                    primary: true,
                    onTap: () => ref.read(_sessionProvider.notifier).reveal(),
                  ),
                ),
        ),
      ],
    );
  }
}

class _RatingRow extends ConsumerWidget {
  const _RatingRow({
    required this.intervals,
    required this.compact,
    required this.showShortcut,
  });

  final Map<fsrs.Rating, DateTime>? intervals;
  final bool compact;
  final bool showShortcut;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = LumenTokens.of(context);
    final buttons = [
      (fsrs.Rating.again, 'Again', LumenColors.again, '1'),
      (fsrs.Rating.hard, 'Hard', LumenColors.hard, '2'),
      (fsrs.Rating.good, 'Good', LumenColors.good, '3'),
      (fsrs.Rating.easy, 'Easy', LumenColors.easy, '4'),
    ];

    if (compact) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: t.surface,
          border: Border(top: BorderSide(color: t.border)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
            child: Row(
              children: [
                for (final item in buttons)
                  Expanded(
                    child: _MobileRate(
                      label: item.$2,
                      color: item.$3,
                      interval: _fmt(intervals?[item.$1]),
                      onTap: () => ref.read(_sessionProvider.notifier).rate(item.$1),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        for (var i = 0; i < buttons.length; i++) ...[
          if (i > 0) const SizedBox(width: 10),
          Expanded(
            child: LumenButton(
              label: buttons[i].$2,
              shortcut: showShortcut
                  ? '${buttons[i].$4}  ${_fmt(intervals?[buttons[i].$1])}'
                  : _fmt(intervals?[buttons[i].$1]),
              color: buttons[i].$3,
              expanded: true,
              onTap: () => ref.read(_sessionProvider.notifier).rate(buttons[i].$1),
            ),
          ),
        ],
      ],
    );
  }

  String _fmt(DateTime? due) {
    if (due == null) return '';
    final now = DateTime.now().toUtc();
    final d = due.difference(now);
    if (d.inMinutes < 10) return '<10m';
    if (d.inHours < 1) return '${d.inMinutes}m';
    if (d.inHours < 24) return '${d.inHours}h';
    if (d.inDays < 30) return '${d.inDays}d';
    return DateFormat('MMM d').format(due.toLocal());
  }
}

class _MobileRate extends StatelessWidget {
  const _MobileRate({
    required this.label,
    required this.color,
    required this.interval,
    required this.onTap,
  });

  final String label;
  final Color color;
  final String interval;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              interval.isEmpty ? '—' : interval,
              style: TextStyle(
                color: color.withValues(alpha: 0.7),
                fontSize: 12,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardFace extends StatelessWidget {
  const _CardFace({
    required this.card,
    required this.revealed,
    required this.compact,
    required this.dividerColor,
  });

  final StudyCard card;
  final bool revealed;
  final bool compact;
  final Color dividerColor;

  @override
  Widget build(BuildContext context) {
    final r = card.rendered;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CardText(text: r.front, hero: true, compact: compact),
        CardAv(
          key: ValueKey('front-${card.card.id}'),
          images: r.frontImages,
          audio: r.frontAudio,
          video: r.frontVideo,
        ),
        if (revealed) ...[
          Padding(
            padding: EdgeInsets.symmetric(vertical: compact ? 24 : 28),
            child: SizedBox(
              width: compact ? 40 : double.infinity,
              height: 1,
              child: ColoredBox(color: dividerColor),
            ),
          ),
          _CardText(text: r.back, hero: false, compact: compact),
          CardAv(
            key: ValueKey('back-${card.card.id}'),
            images: _notIn(r.backImages, r.frontImages),
            audio: _notIn(r.backAudio, r.frontAudio),
            video: _notIn(r.backVideo, r.frontVideo),
          ),
        ],
      ],
    );
  }
}

List<String> _notIn(List<String> items, List<String> exclude) {
  return items.where((item) => !exclude.contains(item)).toList();
}

class _CardText extends StatelessWidget {
  const _CardText({required this.text, required this.hero, this.compact = false});

  final String text;
  final bool hero;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    final style = TextStyle(
      color: t.text,
      fontSize: compact ? (hero ? 32 : 20) : (hero ? 32 : 22),
      height: 1.35,
      fontWeight: FontWeight.w400,
      fontFamilyFallback: t.serifFamily,
      decoration: TextDecoration.none,
    );
    final value = text.isEmpty ? '—' : text;
    if (compact) {
      return Text(value, textAlign: TextAlign.center, style: style);
    }
    return SelectableText(value, textAlign: TextAlign.center, style: style);
  }
}
