import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../../../theme/login_app_color.dart';

class ShimmerLayout extends StatelessWidget {
  final Decoration? decoration;
  final double? width;
  final double height;
  const ShimmerLayout({
    Key? key,
    this.width,
    required this.height,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: LoginAppColor.whiteColor,
      highlightColor: LoginAppColor.dividerColor,
      child: Container(
        decoration: decoration,
        width: width ?? double.infinity,
        height: height,
      ),
    );
  }
}
