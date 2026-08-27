import 'package:flutter/material.dart';

import '../theme/lumen_theme.dart';

class LumenButton extends StatelessWidget {
  const LumenButton({
    super.key,
    required this.label,
    required this.onTap,
    this.primary = false,
    this.color,
    this.shortcut,
    this.expanded = false,
  });

  final String label;
  final VoidCallback? onTap;
  final bool primary;
  final Color? color;
  final String? shortcut;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    final fg = color ?? (primary ? t.bg : t.text);
    final bg = color != null
        ? color!.withValues(alpha: 0.14)
        : (primary ? t.accent : t.elevated);
    final border = color ?? (primary ? t.accent : t.border);

    final child = DecoratedBox(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border.withValues(alpha: color != null ? 0.4 : 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: color ?? fg,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
            if (shortcut != null) ...[
              const SizedBox(width: 8),
              Text(
                shortcut!,
                style: TextStyle(
                  color: (color ?? fg).withValues(alpha: 0.55),
                  fontSize: 11,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ],
        ),
      ),
    );

    return MouseRegion(
      cursor: onTap == null ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: expanded ? SizedBox(width: double.infinity, child: child) : child,
      ),
    );
  }
}
