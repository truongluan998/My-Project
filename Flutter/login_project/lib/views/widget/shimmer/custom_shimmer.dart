import 'package:flutter/widgets.dart';
import 'package:login_project/theme/login_app_color.dart';
import 'package:login_project/views/widget/shimmer/shimmer_layout.dart';

import '../../../config/size_config.dart';
import '../../../constants/constants.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerLayout(
          height: SizeConfig.screenHeight! * Dimens.heightProductImage,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.size16),
            color: LoginAppColor.shadowBackButtonColor,
          ),
        ),
        const SizedBox(height: Dimens.size10),
        ShimmerLayout(
          height: Dimens.size20,
          width: Dimens.size200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.size16),
            color: LoginAppColor.shadowBackButtonColor,
          ),
        ),
        const SizedBox(height: Dimens.size10),
        ShimmerLayout(
          height: Dimens.size16,
          width: Dimens.size100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.size16),
            color: LoginAppColor.shadowBackButtonColor,
          ),
        ),
      ],
    );
  }
}
