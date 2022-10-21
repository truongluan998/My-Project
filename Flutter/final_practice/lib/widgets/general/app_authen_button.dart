import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../theme/final_practice_color.dart';

class AppAuthenButton extends StatelessWidget {
  const AppAuthenButton({
    required this.text,
    required this.press,
    Key? key,
  }) : super(key: key);

  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: press,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(DimensionConstant.PADDING_20),
        shape: const StadiumBorder(),
        backgroundColor: FinalPracticeColor.whiteColor,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: FinalPracticeColor.orangeLightColor,
        ),
      ),
    ),
  );
}
