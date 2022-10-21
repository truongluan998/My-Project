import 'package:flutter/material.dart';
import '../../../const/constants.dart';

class CustomAdvertisingScreen extends StatelessWidget {
  const CustomAdvertisingScreen({
    required this.image,
    required this.title,
    required this.content,
    Key? key,
  }) : super(key: key);

  final String image;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Center(
        child: Image.asset(
          image,
        ),
      ),
      Positioned(
        bottom: DimensionConstant.POSITIONED_0,
        right: DimensionConstant.POSITIONED_0,
        left: DimensionConstant.POSITIONED_0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensionConstant.PADDING_56,
            vertical: DimensionConstant.PADDING_32,),
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DimensionConstant.HEIGHT_16),
              Text(
                content,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      )
    ],
  );
}
