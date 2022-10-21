import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../dependencies/app_dependencies.dart';
import '../../theme/final_practice_color.dart';
import '../../utility/utility.dart';

class ExploreButtonOnBoarding extends StatelessWidget {
  const ExploreButtonOnBoarding({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _utility = AppDependencies.injector.get<Utils>();
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        elevation: DimensionConstant.ELEVATION_0,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(DimensionConstant.BORDER_RADIUS_12),
        ),
        padding: const EdgeInsets.all(DimensionConstant.PADDING_16),
        onPressed: () {
          _utility.setPrefsToOpenOnBoarding('key_on_boarding', true);
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/main',
            (route) => false,
          );
        },
        color: FinalPracticeColor.primaryButtonColor
            .withOpacity(DimensionConstant.OPACITY_0_DOT_6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimensionConstant.PADDING_16,
              ),
              child: Text(
                LabelConstant.EXPLORE_COLLECTION,
                style: Theme.of(context).textTheme.button,
              ),
            ),
            const Icon(
              Icons.navigate_next_sharp,
              color: FinalPracticeColor.whiteColor,
              size: DimensionConstant.SIZE_32,
            )
          ],
        ),
      ),
    );
  }
}
