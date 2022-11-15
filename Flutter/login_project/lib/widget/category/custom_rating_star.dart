import 'package:flutter/material.dart';

import '../../config/theme_config.dart';
import '../../constants/constants.dart';
import '../../theme/login_app_color.dart';
import '../custom_title.dart';

class CustomRatingStar extends StatelessWidget {
  const CustomRatingStar({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final String rating;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: Dimens.size10,
      bottom: Dimens.size55,
      child: Container(
        width: Dimens.size46,
        height: Dimens.size20,
        decoration: BoxDecoration(
          color: LoginAppColor.ratingColor,
          borderRadius: BorderRadius.circular(Dimens.size10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTitle(
              title: rating,
              textTheme: ThemeConfig.textTheme.subtitle2!.copyWith(
                color: LoginAppColor.whiteColor,
              ),
            ),
            const Icon(
              Icons.star,
              size: Dimens.size16,
              color: LoginAppColor.whiteColor,
            )
          ],
        ),
      ),
    );
  }
}
