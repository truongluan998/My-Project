import 'package:flutter/material.dart';
import '../../../const/constants.dart';
import '../../../theme/netflix_clone_color.dart';

class NeedHelpTextButton extends StatelessWidget {
  const NeedHelpTextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextButton(
    child: const Text(
      LabelConstant.NEED_HELP,
      style: TextStyle(
        fontSize: DimensionConstant.FONT_SIZE_16,
        color: NetflixCloneColor.textWhiteDarkColor,
      ),
    ),
    onPressed: () => openURL(PathConstant.URL_HELP_NETFLIX),
  );
}
