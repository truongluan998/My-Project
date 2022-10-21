import 'package:flutter/material.dart';
import '../../const/constants.dart';
import '../../theme/netflix_clone_color.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.press,
    required this.text,
    Key? key,
  }) : super(key: key);

  final VoidCallback press;
  final String text;

  @override
  Widget build(BuildContext context) => MaterialButton(
        onPressed: press,
        elevation: DimensionConstant.ELEVATION_0,
        color: NetflixCloneColor.redColor,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(DimensionConstant.PADDING_12),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: NetflixCloneColor.textWhiteColor),
            ),
          ),
        ),
      );
}
