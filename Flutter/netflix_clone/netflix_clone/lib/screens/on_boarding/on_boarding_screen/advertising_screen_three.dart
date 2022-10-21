import 'package:flutter/material.dart';

import '../../../const/constants.dart';
import '../../../widgets/onboarding_screen/custom_advertising_screen.dart';

class AdvertisingScreenThree extends StatelessWidget {
  const AdvertisingScreenThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: CustomAdvertisingScreen(
      content: LabelConstant.CONTENT_ADVERTISING_SCREEN_THREE,
      title: LabelConstant.TITLE_ADVERTISING_SCREEN_THREE,
      image: PathConstant.IMAGE_ADVERTISING_SCREEN_THREE,
    ),
  );
}
