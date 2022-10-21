import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomIndicatorLoading extends StatelessWidget {
  const CustomIndicatorLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const SizedBox(
        width: double.infinity,
        height: 200,
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
}
