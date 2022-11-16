import 'package:flutter/material.dart';
import 'package:login_project/constants/constants.dart';

import 'custom_shimmer.dart';

class ShimmerCategoryItem extends StatelessWidget {
  const ShimmerCategoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: const [
          CustomShimmer(),
          SizedBox(height: Dimens.size16),
          CustomShimmer(),
          SizedBox(height: Dimens.size16),
          CustomShimmer(),
        ],
      ),
    );
  }
}
