import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository.dart';
import '../../providers.dart';
import '../../theme/lumen_theme.dart';

class BrowserPanel extends ConsumerStatefulWidget {
  const BrowserPanel({super.key});

  @override
  ConsumerState<BrowserPanel> createState() => _BrowserPanelState();
}

class _BrowserPanelState extends ConsumerState<BrowserPanel> {
  final _query = TextEditingController();
  List<BrowseRow> _rows = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  Future<void> _reload() async {
    setState(() => _loading = true);
    final deckId = ref.read(selectionProvider).deckId;
    final rows = await ref.read(repositoryProvider).browse(
          deckId: deckId,
          query: _query.text,
        );
    if (!mounted) return;
    setState(() {
      _rows = rows;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    return ColoredBox(
      color: t.bg,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              LumenTokens.phone(context) ? 16 : 24,
              LumenTokens.phone(context) ? 8 : 20,
              LumenTokens.phone(context) ? 16 : 24,
              12,
            ),
            child: LumenTokens.phone(context)
                ? TextField(
                    controller: _query,
                    decoration: const InputDecoration(hintText: 'Search notes'),
                    onSubmitted: (_) => _reload(),
                  )
                : Row(
                    children: [
                      Text(
                        'Browser',
                        style: TextStyle(
                          color: t.text,
                          fontSize: 18,
                          fontFamilyFallback: t.serifFamily,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _query,
                          decoration: const InputDecoration(hintText: 'Search notes'),
                          onSubmitted: (_) => _reload(),
                        ),
                      ),
                    ],
                  ),
          ),
          Divider(height: 1, color: t.border),
          Expanded(
            child: _loading
                ? Center(child: Text('Loading', style: TextStyle(color: t.muted)))
                : ListView.separated(
                    itemCount: _rows.length,
                    separatorBuilder: (_, __) => Divider(height: 1, color: t.border),
                    itemBuilder: (context, i) {
                      final row = _rows[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    row.front,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: t.text, fontSize: 14),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    row.back,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: t.muted, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              row.suspended ? 'Suspended' : row.state,
                              style: TextStyle(color: t.faint, fontSize: 12),
                            ),
                            const SizedBox(width: 12),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () async {
                                  await ref
                                      .read(repositoryProvider)
                                      .setSuspended(row.cardId, !row.suspended);
                                  await _reload();
                                  bumpLibrary(ref);
                                },
                                child: Text(
                                  row.suspended ? 'Unsuspend' : 'Suspend',
                                  style: TextStyle(color: t.accent, fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
