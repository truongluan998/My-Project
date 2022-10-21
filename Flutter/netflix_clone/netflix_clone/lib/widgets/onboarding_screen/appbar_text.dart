import 'package:flutter/material.dart';
import '../../../const/constants.dart';

class AppBarText extends StatelessWidget {
  const AppBarText({
    required this.text,
    required this.press,
    Key? key,
  }) : super(key: key);

  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: press,
    child: Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(fontSize: DimensionConstant.FONT_SIZE_14),
    ),
  );
}
