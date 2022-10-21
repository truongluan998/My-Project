import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../constants/constants.dart';

class CustomOpacityOfImage extends StatelessWidget {
  const CustomOpacityOfImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    height: SizeConfig.screenHeight *
        DimensionConstant.HEIGHT_0_DOT_45,
    color: Colors.black
        .withOpacity(DimensionConstant.OPACITY_0_DOT_2),
  );
}
