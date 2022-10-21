import 'package:flutter/material.dart';

import '../../../const/constants.dart';
import '../../../widgets/onboarding_screen/custom_advertising_screen.dart';


class AdvertisingScreenOne extends StatelessWidget {
  const AdvertisingScreenOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: CustomAdvertisingScreen(
          content: LabelConstant.CONTENT_ADVERTISING_SCREEN_ONE,
          title: LabelConstant.TITLE_ADVERTISING_SCREEN_ONE,
          image: PathConstant.IMAGE_ADVERTISING_SCREEN_ONE,
        ),
      );
}
