import 'package:flutter/material.dart';

class CatigoriesCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double y = size.height;

    double x = size.width;

    Path path = Path();
    path.moveTo(x, 0);
    path.lineTo(x, 0);
    path.lineTo(0, 0);
    path.lineTo(0.01 * x, y * 0.2);

    path.quadraticBezierTo(0.01 * x, y / 2, 0.1 * x, y);
    // path.lineTo(0.25 * x, y);
    path.lineTo(0.75 * x, y);

    // path.quadraticBezierTo(0.75 * x, y * 0.3, x * 0.5, y * 0.28);
    // path.quadraticBezierTo(0.75 * x, y * 0.3, x * 0.5, y * 0.28);

    // path.quadraticBezierTo(0.25 * x, y * 0.27, 0, y * 0.30);

    // path.lineTo(0, y * 0.26);
    // path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
