import 'package:flutter/material.dart';

import '../../../const/constants.dart';
import '../../../widgets/onboarding_screen/custom_advertising_screen.dart';

class AdvertisingScreenFour extends StatelessWidget {
  const AdvertisingScreenFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: CustomAdvertisingScreen(
          content: LabelConstant.CONTENT_ADVERTISING_SCREEN_FOUR,
          title: LabelConstant.TITLE_ADVERTISING_SCREEN_FOUR,
          image: PathConstant.IMAGE_ADVERTISING_SCREEN_FOUR,
        ),
      );
}
