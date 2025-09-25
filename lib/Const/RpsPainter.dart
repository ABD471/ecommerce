import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill1 = Paint()
      ..color = const Color.fromARGB(255, 19, 36, 180)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.0050000, 0);
    path_1.lineTo(0, size.height * 0.6633333);
    path_1.quadraticBezierTo(size.width * 0.0018750, size.height * 1.0226667,
        size.width * 0.2825000, size.height * 0.9966667);
    path_1.cubicTo(
        size.width * 0.4208750,
        size.height * 0.9956667,
        size.width * 0.5636250,
        size.height * 0.8070000,
        size.width * 0.6760000,
        size.height * 0.7313333);
    path_1.cubicTo(
        size.width * 0.8118750,
        size.height * 0.7256667,
        size.width * 0.7766250,
        size.height * 0.6083333,
        size.width * 0.8715000,
        size.height * 0.5673333);
    path_1.quadraticBezierTo(size.width * 1.0028750, size.height * 0.5061667,
        size.width * 1.0050000, size.height * 0.2266667);
    path_1.lineTo(size.width * 0.9975000, 0);

    canvas.drawPath(path_1, paintFill1);

    // Layer 1

    Paint paintStroke1 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_1, paintStroke1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
