import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopUpDecor extends CustomPainter {
  final Color color;

  PopUpDecor({@required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height-20);
    path.quadraticBezierTo(size.width/4, size.height, size.width/2, size.height-20,);
    path.quadraticBezierTo(size.width*(3/4), size.height-40, size.width, size.height-20);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}