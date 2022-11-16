import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../theme/login_app_color.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback press;
  final bool isShowBorder;
  const CustomBackButton({
    Key? key,
    required this.press,
    this.isShowBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimens.size38,
      height: Dimens.size38,
      child: ElevatedButton(
        onPressed: press,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(LoginAppColor.whiteColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.size12),
              side: isShowBorder
                  ? const BorderSide(color: LoginAppColor.balloonTwoColor)
                  : const BorderSide(color: LoginAppColor.whiteColor),
            ),
          ),
          elevation: MaterialStateProperty.all(Dimens.size4),
          shadowColor: MaterialStateProperty.all(
            LoginAppColor.whiteColor.withOpacity(
              Dimens.opa0Dot3,
            ),
          ),
        ),
        child: const Icon(
          Icons.arrow_back_ios,
          color: LoginAppColor.blackColor,
          size: Dimens.size16,
        ),
      ),
    );
  }
}
