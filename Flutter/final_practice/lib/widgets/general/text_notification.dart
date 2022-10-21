import 'package:flutter/material.dart';

class TextNotification extends StatelessWidget {
  const TextNotification({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) => Center(
    child: Text(text),
  );
}
