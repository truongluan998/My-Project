import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DefaultShimmer extends StatelessWidget {
  const DefaultShimmer({
    required this.widget,
    Key? key,
    this.duration = const Duration(seconds: 1),
  }) : super(key: key);

  final Widget widget;
  final Duration duration;

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey[500]!,
        highlightColor: Colors.grey[100]!,
        period: duration,
        child: widget,
      );
}
