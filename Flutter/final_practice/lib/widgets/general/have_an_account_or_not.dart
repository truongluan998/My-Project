import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class HaveAnAccountOrNot extends StatelessWidget {
  const HaveAnAccountOrNot({
    required this.text,
    required this.textButton,
    required this.press,
    Key? key,
  }) : super(key: key);

  final String text;
  final String textButton;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontSize: DimensionConstant.FONT_SIZE_14),
          ),
          TextButton(
            onPressed: press,
            child: Text(
              textButton,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontSize: DimensionConstant.FONT_SIZE_15),
            ),
          ),
        ],
      );
}
