import 'package:flutter/material.dart';

class CustomTextDetailsSmall extends StatelessWidget {
  const CustomTextDetailsSmall({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle2,
      );
}
