import 'package:flutter/material.dart';

import '../../../config/theme_config.dart';
import '../../../theme/login_app_color.dart';

class CustomDividerAndText extends StatelessWidget {
  final String title;
  const CustomDividerAndText({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: LoginAppColor.dividerColor,
            thickness: 0.5,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              title,
              style: ThemeConfig.textTheme.bodyText2,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: LoginAppColor.dividerColor,
            thickness: 0.5,
          ),
        ),
      ],
    );
  }
}