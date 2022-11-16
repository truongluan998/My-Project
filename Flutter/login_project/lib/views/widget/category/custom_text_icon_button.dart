import 'package:flutter/material.dart';

import '../../../config/theme_config.dart';
import '../../../constants/constants.dart';
import '../../../theme/login_app_color.dart';
import '../custom_title.dart';

class CustomTextIconButton extends StatelessWidget {
  final String title;
  final VoidCallback press;

  const CustomTextIconButton({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextButton.icon(
        onPressed: press,
        icon: const Icon(
          size: Dimens.size16,
          Icons.keyboard_arrow_down_sharp,
          color: LoginAppColor.titleTextColor,
        ),
        label: CustomTitle(
          title: title,
          textTheme: ThemeConfig.textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w500,
            color: LoginAppColor.balloonTwoColor,
          ),
        ),
      ),
    );
  }
}
