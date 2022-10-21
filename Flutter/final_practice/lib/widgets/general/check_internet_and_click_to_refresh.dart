import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../constants/constants.dart';

class CheckInternetAndClickToRefresh extends StatelessWidget {
  const CheckInternetAndClickToRefresh({
    required this.press,
    Key? key,
  }) : super(key: key);

  final VoidCallback press;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: SizeConfig.screenHeight * DimensionConstant.HEIGHT_0_DOT_8,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(
          right: DimensionConstant.PADDING_16,
        ),
        child: TextButton(
          onPressed: press,
          child: Text(
            LabelConstant.CHECK_INTERNET,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ),
    ),
  );
}
