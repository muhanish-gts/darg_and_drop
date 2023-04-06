import 'dart:math';

import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final List<Point<double>> points;

  LinePainter({
    required this.points,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    final paint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 2;
    path.moveTo(points[0].x, points[0].y);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].x, points[i].y);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
