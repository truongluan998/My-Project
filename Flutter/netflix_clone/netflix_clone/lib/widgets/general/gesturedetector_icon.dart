import 'package:flutter/material.dart';

class GestureDetectorIcon extends StatelessWidget {
  const GestureDetectorIcon({
    
    required this.icon,
    required this.press,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: press,
    child: Icon(
      icon,
      color: Colors.white,
    ),
  );
}
