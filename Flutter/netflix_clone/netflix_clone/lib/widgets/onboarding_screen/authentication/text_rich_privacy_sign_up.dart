import 'package:flutter/material.dart';
import '../../../const/constants.dart';

class TextRichPrivacySignUp extends StatelessWidget {
  const TextRichPrivacySignUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const Text.rich(
        TextSpan(
          text: LabelConstant.CLICK_BELOW,
          style: TextStyle(
            fontSize: DimensionConstant.FONT_SIZE_17,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: LabelConstant.TERMS_OF_USE,
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
            TextSpan(
              text: LabelConstant.OVER_18_YEARS_OLD,
            ),
          ],
        ),
      );
}
