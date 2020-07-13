import 'package:ec_senior/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBarBackgroundPrimary extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = MyColors.primary;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5.0;

    var path = Path();

    path.lineTo(size.width/4.0 - 10.0, 0);
    path.quadraticBezierTo(size.width/4.0  - 3.0, 2.0, size.width/4.0, 10.0);
    path.lineTo(size.width/4.0, size.height - 30.0);
    path.quadraticBezierTo(size.width/4.0 + 6.0, size.height - 15.0, size.width/4.0 + 20.0, size.height - 10.0);
    path.lineTo(size.width * (3/4) - 20.0, size.height - 10.0);
    path.quadraticBezierTo(size.width * (3/4) - 6.0 , size.height - 15.0, size.width * (3/4), size.height - 30.0);
    path.lineTo(size.width * (3/4), 10.0);
    path.quadraticBezierTo(size.width *(3/4) + 3.0, 2.0, size.width * (3/4) +10.0, 0.0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}



class NavBarBackgroundSecondary extends CustomPainter {
 @override
  void paint(Canvas canvas, Size size) {
   final paint = Paint();
   paint.color = Color(0xffffc107);
   paint.style = PaintingStyle.fill;

   final path = Path();
   path.lineTo(size.width * (3/4) - 20.0, 0);
   path.quadraticBezierTo(size.width * (3/4) - 13.0, 2.0, size.width * (3/4) - 10.0, 10.0);
   path.lineTo(size.width * (3/4) -10.0, size.height - 30.0);
   path.quadraticBezierTo(size.width * (3/4) - 4.0, size.height - 15.0, size.width * (3/4) + 10.0, size.height - 10.0);
   path.lineTo(size.width - 30.0, size.height - 10.0);
   path.quadraticBezierTo(size.width - 16.0, size.height - 15.0, size.width - 10.0, size.height - 30.0);
   path.lineTo(size.width - 10.0, 10.0);
   path.quadraticBezierTo(size.width - 7.0, 2.0, size.width, 0.0);
   path.lineTo(size.width, size.height);
   path.lineTo(0, size.height);

   canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}