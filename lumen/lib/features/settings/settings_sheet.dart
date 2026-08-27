import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers.dart';
import '../../theme/lumen_theme.dart';
import '../../widgets/lumen_button.dart';

Future<void> showSettingsSheet(BuildContext context, WidgetRef ref) {
  if (LumenTokens.phone(context)) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: LumenTokens.of(context).elevated,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => const _SettingsDialog(),
    );
  }
  return showDialog<void>(
    context: context,
    builder: (_) => const _SettingsDialog(),
  );
}

class _SettingsDialog extends ConsumerStatefulWidget {
  const _SettingsDialog();

  @override
  ConsumerState<_SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends ConsumerState<_SettingsDialog> {
  late final TextEditingController _newPerDay;
  late final TextEditingController _retention;

  @override
  void initState() {
    super.initState();
    _newPerDay = TextEditingController(text: '20');
    _retention = TextEditingController(text: '0.90');
    _load();
  }

  Future<void> _load() async {
    final db = ref.read(databaseProvider);
    _newPerDay.text = await db.readSetting('new_per_day') ?? '20';
    _retention.text = await db.readSetting('desired_retention') ?? '0.90';
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _newPerDay.dispose();
    _retention.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final db = ref.read(databaseProvider);
    await db.upsertSetting('new_per_day', _newPerDay.text.trim());
    await db.upsertSetting('desired_retention', _retention.text.trim());
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    final mode = ref.watch(themeModeProvider);
    final form = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Appearance', style: TextStyle(color: t.faint, fontSize: 11, letterSpacing: 1.2)),
        const SizedBox(height: 10),
        Row(
          children: [
            _chip(context, 'System', mode == ThemeMode.system, () {
              ref.read(themeModeProvider.notifier).setMode(ThemeMode.system);
            }),
            const SizedBox(width: 8),
            _chip(context, 'Dark', mode == ThemeMode.dark, () {
              ref.read(themeModeProvider.notifier).setMode(ThemeMode.dark);
            }),
            const SizedBox(width: 8),
            _chip(context, 'Light', mode == ThemeMode.light, () {
              ref.read(themeModeProvider.notifier).setMode(ThemeMode.light);
            }),
          ],
        ),
        const SizedBox(height: 22),
        Text('Study', style: TextStyle(color: t.faint, fontSize: 11, letterSpacing: 1.2)),
        const SizedBox(height: 10),
        TextField(
          controller: _newPerDay,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'New cards per day'),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _retention,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(hintText: 'Desired retention (0.80–0.97)'),
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
                'Settings',
                style: TextStyle(
                  color: t.text,
                  fontSize: 22,
                  fontFamilyFallback: t.serifFamily,
                ),
              ),
              const SizedBox(height: 18),
              form,
              const SizedBox(height: 22),
              LumenButton(label: 'Save', primary: true, expanded: true, onTap: _save),
            ],
          ),
        ),
      );
    }

    return AlertDialog(
      title: Text(
        'Settings',
        style: TextStyle(
          color: t.text,
          fontSize: 18,
          fontFamilyFallback: t.serifFamily,
        ),
      ),
      content: SizedBox(width: 400, child: form),
      actions: [
        LumenButton(label: 'Close', onTap: () => Navigator.pop(context)),
        LumenButton(label: 'Save', primary: true, onTap: _save),
      ],
    );
  }

  Widget _chip(BuildContext context, String label, bool on, VoidCallback tap) {
    final t = LumenTokens.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: tap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: on ? t.accent.withValues(alpha: 0.16) : t.elevated,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: on ? t.accent : t.border),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              label,
              style: TextStyle(color: on ? t.accent : t.muted, fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}
