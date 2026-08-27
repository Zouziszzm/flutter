import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../import/apkg_importer.dart';
import '../../providers.dart';
import '../../theme/lumen_theme.dart';
import '../../widgets/lumen_button.dart';

Future<void> showImportSheet(
  BuildContext context,
  WidgetRef ref,
  String path,
) {
  if (LumenTokens.phone(context)) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: LumenTokens.of(context).elevated,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: _ImportDialog(path: path),
      ),
    );
  }
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => _ImportDialog(path: path),
  );
}

class _ImportDialog extends ConsumerStatefulWidget {
  const _ImportDialog({required this.path});

  final String path;

  @override
  ConsumerState<_ImportDialog> createState() => _ImportDialogState();
}

class _ImportDialogState extends ConsumerState<_ImportDialog> {
  ImportReport? _report;
  String? _error;
  bool _busy = true;

  @override
  void initState() {
    super.initState();
    _run();
  }

  Future<void> _run() async {
    try {
      final report = await ref.read(importerProvider).importFile(File(widget.path));
      if (!mounted) return;
      setState(() {
        _report = report;
        _busy = false;
      });
      bumpLibrary(ref);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = '$e';
        _busy = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    final filename = widget.path.split('/').last;
    final body = _busy
        ? Text(
            'Reading $filename…',
            style: TextStyle(color: t.muted, height: 1.5, fontSize: 15),
          )
        : _error != null
            ? Text(_error!, style: const TextStyle(color: LumenColors.again, height: 1.5))
            : _ReportBody(report: _report!);

    if (LumenTokens.phone(context)) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: t.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              'Import',
              style: TextStyle(
                color: t.text,
                fontSize: 22,
                fontFamilyFallback: t.serifFamily,
              ),
            ),
            const SizedBox(height: 14),
            body,
            if (!_busy) ...[
              const SizedBox(height: 22),
              LumenButton(
                label: 'Done',
                primary: true,
                expanded: true,
                onTap: () => Navigator.pop(context),
              ),
            ],
          ],
        ),
      );
    }

    return AlertDialog(
      title: Text(
        'Import',
        style: TextStyle(
          color: t.text,
          fontSize: 18,
          fontFamilyFallback: t.serifFamily,
        ),
      ),
      content: SizedBox(width: 420, child: body),
      actions: [
        if (!_busy)
          LumenButton(
            label: 'Done',
            primary: true,
            onTap: () => Navigator.pop(context),
          ),
      ],
    );
  }
}

class _ReportBody extends StatelessWidget {
  const _ReportBody({required this.report});

  final ImportReport report;

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          report.rootDeckName,
          style: TextStyle(color: t.text, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Text(
          '${report.notes} notes  ·  ${report.cards} cards  ·  ${report.decks} decks  ·  ${report.media} media',
          style: TextStyle(color: t.muted, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 8),
        Text(
          'Scheduling starts fresh with FSRS.',
          style: TextStyle(color: t.faint, fontSize: 12),
        ),
        if (report.warnings.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('Notes', style: TextStyle(color: t.muted, fontSize: 12)),
          const SizedBox(height: 6),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 160),
            child: ListView(
              shrinkWrap: true,
              children: [
                for (final w in report.warnings)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(w, style: TextStyle(color: t.faint, fontSize: 12)),
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
