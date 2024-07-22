import 'package:flutter/material.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class ArcClipper extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white10
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    canvas.drawCircle(Offset.zero, 60, paint);
    canvas.drawCircle(Offset(size.width / 2, size.height), 60, paint);

    var paint1 = Paint()
      ..color = Colors.white10
      ..style = PaintingStyle.fill
      ..strokeWidth = 10;

    final center = Offset(size.width, size.height / 2);
    final radius = size.width / 10;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
