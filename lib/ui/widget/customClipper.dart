import 'package:flutter/material.dart';

class CustomPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 2 / 3);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 2 / 3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
