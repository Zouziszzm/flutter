import 'package:flutter/material.dart';

/// The Lumen mark from brand/mark.svg (viewBox 0 0 10 11).
class LumenMark extends StatelessWidget {
  const LumenMark({super.key, required this.color, this.size = 22});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size * 10 / 11, size),
      painter: _MarkPainter(color),
    );
  }
}

class _MarkPainter extends CustomPainter {
  _MarkPainter(this.color);

  final Color color;

  static const _rects = [
    Rect.fromLTRB(4.22399, 0, 5.15999, 9.27588),
    Rect.fromLTRB(0, 2.61588, 0.91199, 10.6439),
    Rect.fromLTRB(8.60399, 2.60388, 9.51599, 10.5959),
    Rect.fromLTRB(0.45599, 8.74788, 8.99999, 9.67188),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.height / 11;
    final dx = (size.width - 10 * scale) / 2;
    final paint = Paint()..color = color;
    for (final rect in _rects) {
      canvas.drawRect(
        Rect.fromLTRB(
          dx + rect.left * scale,
          rect.top * scale,
          dx + rect.right * scale,
          rect.bottom * scale,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_MarkPainter oldDelegate) => oldDelegate.color != color;
}
