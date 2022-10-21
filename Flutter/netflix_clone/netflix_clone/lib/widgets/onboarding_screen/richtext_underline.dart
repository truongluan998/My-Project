import 'package:flutter/material.dart';
import '../../const/constants.dart';

class RichTextUnderline extends StatelessWidget {
  const RichTextUnderline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const Text.rich(
    TextSpan(
      text: LabelConstant.LEARN_MORE,
      style: TextStyle(
        fontSize: DimensionConstant.FONT_SIZE_14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      children: [
        TextSpan(
          text: LabelConstant.FREE_PLAN,
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    ),
  );
}
