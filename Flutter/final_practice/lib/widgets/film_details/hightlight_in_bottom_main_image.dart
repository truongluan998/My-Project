import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../constants/constants.dart';

class HighlightInBottomMainImage extends StatelessWidget {
  const HighlightInBottomMainImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        height: SizeConfig.screenHeight * DimensionConstant.HEIGHT_0_DOT_36,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: <Color>[Colors.white, Colors.transparent],
          ),
        ),
      );
}
