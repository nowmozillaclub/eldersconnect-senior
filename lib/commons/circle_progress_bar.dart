import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CircleProgressBar extends CustomPainter {
  final double value;
  final Color foregroundColor;
  final Color backgroundColor;
  final double strokeWidth;

  CircleProgressBar({
    @required this.value, @required this.backgroundColor, @required this.foregroundColor,
    double strokeWidth}) :
        this.strokeWidth = strokeWidth ?? 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = size.center(Offset.zero);
    Size constrainedSize = size - Offset(strokeWidth, strokeWidth);
    double radius = constrainedSize.width/2;

    final foregroundPaint = Paint();
    foregroundPaint.strokeWidth = strokeWidth;
    foregroundPaint.color = foregroundColor;
    foregroundPaint.strokeCap = StrokeCap.round;
    foregroundPaint.style = PaintingStyle.stroke;

    final double startAngle = -(pi);
    final double sweepAngle = (pi *value);

    final backgroundPaint = Paint();
    backgroundPaint.style = PaintingStyle.stroke;
    backgroundPaint.strokeWidth = strokeWidth;
    backgroundPaint.color = backgroundColor.withOpacity(0.25);

//    canvas.drawCircle(center, radius, backgroundPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -(pi), (pi), false, backgroundPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as CircleProgressBar);
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.value != value ||
        oldPainter.foregroundColor != this.foregroundColor ||
        oldPainter.strokeWidth != this.strokeWidth;
  }
}
