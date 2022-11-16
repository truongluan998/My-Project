import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/size_config.dart';
import '../../../config/theme_config.dart';
import '../../../constants/constants.dart';
import '../../../theme/login_app_color.dart';
import '../custom_title.dart';

class LoginWithSocialNetworkButton extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback press;
  const LoginWithSocialNetworkButton({
    Key? key,
    required this.title,
    required this.image,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.size56,
      width: SizeConfig.screenWidth! * Dimens.size0Dot392,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(LoginAppColor.whiteColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.size28),
            ),
          ),
          elevation: MaterialStateProperty.all(Dimens.size16),
          shadowColor: MaterialStateProperty.all(
            LoginAppColor.shadowBackButtonColor.withOpacity(Dimens.opa0Dot2),
          ),
        ),
        child: FittedBox(
          child: Row(
            children: [
              SvgPicture.asset(image),
              const SizedBox(width: Dimens.size12),
              CustomTitle(
                title: title.toUpperCase(),
                textTheme: ThemeConfig.textTheme.bodyText2!.copyWith(
                  color: LoginAppColor.textBlackColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
