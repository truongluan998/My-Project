import 'package:final_practice/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../theme/final_practice_color.dart';

class IconPlayVideo extends StatelessWidget {
  const IconPlayVideo({
    required this.press,
    Key? key,
  }) : super(key: key);

  final VoidCallback press;

  @override
  Widget build(BuildContext context) => Positioned.fill(
    child: IconButton(
      onPressed: press,
      icon: const Icon(
        Icons.play_circle_outline_outlined,
        color: FinalPracticeColor.whiteColor,
        size: DimensionConstant.SIZE_60,
      ),
    ),
  );
}
