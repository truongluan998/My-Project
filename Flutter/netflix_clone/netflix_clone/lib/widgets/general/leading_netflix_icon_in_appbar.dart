import 'package:flutter/material.dart';
import '../../const/constants.dart';

class LeadingNetflixIconInAppBar extends StatelessWidget {
  const LeadingNetflixIconInAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(DimensionConstant.PADDING_8),
    child: Image.asset(
      PathConstant.ICON_NETFLIX_APPBAR,
      height: DimensionConstant.WIDTH_32,
      width: DimensionConstant.HEIGHT_32,
    ),
  );
}
