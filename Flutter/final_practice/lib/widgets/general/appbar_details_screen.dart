import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../theme/final_practice_color.dart';

class AppBarDetailsScreen extends StatelessWidget with PreferredSizeWidget {
  const AppBarDetailsScreen({
     this.action,
    Key? key,
  }) : super(key: key);

  final List<Widget>? action;

  @override
  Widget build(BuildContext context) => AppBar(
        backgroundColor: Colors.transparent,
        elevation: DimensionConstant.ELEVATION_0,
        leading: Padding(
          padding: const EdgeInsets.only(left: DimensionConstant.PADDING_12),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: FinalPracticeColor.whiteColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        actions: action,
      );

  @override
  Size get preferredSize =>
      const Size.fromHeight(DimensionConstant.DEFAULT_HEIGHT_APP_BAR);
}
