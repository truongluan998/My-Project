import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../config/theme_config.dart';
import '../../theme/login_app_color.dart';

class DoNotHaveAccountText extends StatelessWidget {
  final VoidCallback press;
  const DoNotHaveAccountText({
    Key? key,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: tr('login_screen.login_do_not_have_account'),
            style: ThemeConfig.textTheme.bodyText2,
          ),
          TextSpan(
              text: tr('login_screen.sign_up'),
              style: ThemeConfig.textTheme.bodyText2!.copyWith(
                color: LoginAppColor.balloonTwoColor,
              ),
              recognizer: TapGestureRecognizer()..onTap = press),
        ],
      ),
    );
  }
}
