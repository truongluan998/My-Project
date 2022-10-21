import 'package:flutter/material.dart';

import '../../../const/constants.dart';
import '../../../widgets/onboarding_screen/custom_advertising_screen.dart';

class AdvertisingScreenTwo extends StatelessWidget {
  const AdvertisingScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: CustomAdvertisingScreen(
          content: LabelConstant.CONTENT_ADVERTISING_SCREEN_TWO,
          title: LabelConstant.TITLE_ADVERTISING_SCREEN_TWO,
          image: PathConstant.IMAGE_ADVERTISING_SCREEN_TWO,
        ),
      );
}
