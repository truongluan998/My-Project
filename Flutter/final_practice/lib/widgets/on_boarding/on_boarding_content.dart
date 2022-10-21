import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../theme/final_practice_color.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Align(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensionConstant.PADDING_36,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LabelConstant.MOVIE_AND_SERIES,
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: DimensionConstant.HEIGHT_28),
              Text(
                LabelConstant.CONTENT_MOVIE_AND_SERIES,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: FinalPracticeColor.whiteColor),
              )
            ],
          ),
        ),
      );
}
