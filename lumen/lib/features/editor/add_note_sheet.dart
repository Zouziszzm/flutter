import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers.dart';
import '../../theme/lumen_theme.dart';
import '../../widgets/lumen_button.dart';

Future<void> showAddNoteSheet(BuildContext context, WidgetRef ref) {
  if (LumenTokens.phone(context)) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: LumenTokens.of(context).elevated,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
        child: const _AddNoteDialog(),
      ),
    );
  }
  return showDialog<void>(
    context: context,
    builder: (_) => const _AddNoteDialog(),
  );
}

class _AddNoteDialog extends ConsumerStatefulWidget {
  const _AddNoteDialog();

  @override
  ConsumerState<_AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends ConsumerState<_AddNoteDialog> {
  final _front = TextEditingController();
  final _back = TextEditingController();
  final _tags = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _front.dispose();
    _back.dispose();
    _tags.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_front.text.trim().isEmpty) return;
    setState(() => _saving = true);
    final repo = ref.read(repositoryProvider);
    final deckId =
        ref.read(selectionProvider).deckId ?? await repo.defaultDeckId();
    await repo.addBasicNote(
      deckId: deckId,
      front: _front.text.trim(),
      back: _back.text.trim(),
      tags: _tags.text.trim(),
    );
    bumpLibrary(ref);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    final fields = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _front,
          autofocus: true,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'Front'),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _back,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'Back'),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _tags,
          decoration: const InputDecoration(hintText: 'Tags (optional)'),
        ),
      ],
    );

    if (LumenTokens.phone(context)) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
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
                'Add card',
                style: TextStyle(
                  color: t.text,
                  fontSize: 22,
                  fontFamilyFallback: t.serifFamily,
                ),
              ),
              const SizedBox(height: 18),
              fields,
              const SizedBox(height: 22),
              LumenButton(
                label: _saving ? 'Saving' : 'Add',
                primary: true,
                expanded: true,
                onTap: _saving ? null : _save,
              ),
            ],
          ),
        ),
      );
    }

    return AlertDialog(
      title: Text(
        'Add card',
        style: TextStyle(
          color: t.text,
          fontSize: 18,
          fontFamilyFallback: t.serifFamily,
        ),
      ),
      content: SizedBox(width: 440, child: fields),
      actions: [
        LumenButton(label: 'Cancel', onTap: () => Navigator.pop(context)),
        LumenButton(
          label: _saving ? 'Saving' : 'Add',
          primary: true,
          onTap: _saving ? null : _save,
        ),
      ],
    );
  }
}
