import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../screens/on_boarding/on_boarding_screen.dart';
import '../../theme/final_practice_color.dart';

class ExploreDotIndicator extends StatelessWidget {
  const ExploreDotIndicator({
    required this.tabController,
    Key? key,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) => DotsIndicator(
        dotsCount: OnBoardingScreen.tabs.length,
        position: tabController.index.toDouble(),
        decorator: DotsDecorator(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1),
          ),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1),
          ),
          spacing: const EdgeInsets.symmetric(
            horizontal: DimensionConstant.PADDING_8,
          ),
          size: const Size.square(DimensionConstant.SIZE_8),
          activeSize: const Size.square(DimensionConstant.SIZE_8),
          activeColor: FinalPracticeColor.primaryButtonColor,
        ),
      );
}
