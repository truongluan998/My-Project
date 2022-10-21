import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class BackGroundOnBoardingScreenFail extends StatelessWidget {
  const BackGroundOnBoardingScreenFail({
    required this.assetImage,
    Key? key,
  }) : super(key: key);

  final String assetImage;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(assetImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(DimensionConstant.OPACITY_0_DOT_6),
        ),
      );
}
