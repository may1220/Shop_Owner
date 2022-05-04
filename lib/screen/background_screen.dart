import 'package:flutter/material.dart';

import '../helpers/styleguide.dart';

class HomeBackgroundPage extends StatelessWidget {
  final screenHeight;

  const HomeBackgroundPage({Key key, @required this.screenHeight})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomShapeClipper(),
      child: Container(
        height: screenHeight * 0.45,
        // color: Color(0xFF302DDD),
        color: color,
      ),
    );
  }
}

class BottomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset curveStartPoint = Offset(0, size.height * 0.75);
    Offset curveEndPoint = Offset(size.width, size.height * 0.75);
    path.lineTo(curveStartPoint.dx, curveStartPoint.dy);
    path.quadraticBezierTo(
        size.width / 2, size.height, curveEndPoint.dx, curveEndPoint.dy);
    path.lineTo(size.width, 0);
    return path;
    // throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
