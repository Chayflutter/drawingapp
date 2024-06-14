import 'package:flutter/material.dart';

class DrawingPoints {
  Paint paint;
  Offset points;
  bool isPoint;

DrawingPoints({
    required this.points,
    required this.paint,
    this.isPoint = true,
  });
}

class DrawingPainter extends CustomPainter {
  List<DrawingPoints> points;
  DrawingPainter({required this.points});
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i].isPoint &&
          points[i + 1].isPoint) {
        canvas.drawLine(
            points[i].points, points[i + 1].points, points[i].paint);
      }
    }
  }
  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) => true;
}