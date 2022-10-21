import 'package:flutter/material.dart';

import '../../../../config/size_config.dart';
import '../../../../const/constants.dart';

class CustomContactButton extends StatelessWidget {
  const CustomContactButton({
    required this.icon,
    required this.text,
    required this.press,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: SizeConfig.screenWidth * DimensionConstant.WIDTH_30_PERCENT,
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(
            vertical: DimensionConstant.PADDING_12,
            horizontal: DimensionConstant.PADDING_12,
          ),
          color: Colors.black,
          onPressed: press,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: DimensionConstant.FONT_SIZE_16,
                ),
              ),
            ],
          ),
        ),
      );
}
