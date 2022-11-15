import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final TextStyle? textTheme;
  const CustomTitle({
    Key? key,
    required this.title,
    required this.textTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textTheme,
      overflow: TextOverflow.ellipsis,
    );
  }
}