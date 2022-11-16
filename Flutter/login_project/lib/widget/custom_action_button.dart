import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../theme/login_app_color.dart';
import 'custom_title.dart';

class CustomActionButton extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final VoidCallback press;
  final TextStyle? textTheme;
  const CustomActionButton({
    Key? key,
    required this.title,
    required this.height,
    required this.width,
    required this.press,
    required this.textTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: press,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(LoginAppColor.balloonTwoColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.size28),
            ),
          ),
          elevation: MaterialStateProperty.all(Dimens.size4),
          shadowColor: MaterialStateProperty.all(
            LoginAppColor.shadowActionButtonColor.withOpacity(Dimens.opa0Dot1),
          ),
        ),
        child: CustomTitle(
          title: title.toUpperCase(),
          textTheme: textTheme,
        ),
      ),
    );
  }
}
