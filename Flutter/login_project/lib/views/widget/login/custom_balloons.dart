import 'package:flutter/material.dart';

class CustomBalloons extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  const CustomBalloons({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color, // border color
        shape: BoxShape.circle,
      ),
    );
  }
}
