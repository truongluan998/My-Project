import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import 'app_circular_progress_indcator.dart';

class LayerInvisibleLoading extends StatelessWidget {
  const LayerInvisibleLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(DimensionConstant.OPACITY_0_DOT_3),
        child: const AppCircularProgressIndicator(),
      );
}
