import 'package:flutter/material.dart';
import '../../../const/constants.dart';

class CustomTextNormalSize extends StatelessWidget {
  const CustomTextNormalSize({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      color: Colors.white,
      fontSize: DimensionConstant.FONT_SIZE_16,
    ),
  );
}
