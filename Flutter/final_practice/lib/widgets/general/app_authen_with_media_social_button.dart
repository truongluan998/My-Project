import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class AppAuthenWithMediaSocialButton extends StatelessWidget {
  const AppAuthenWithMediaSocialButton({
    required this.text,
    required this.color,
    Key? key,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(DimensionConstant.PADDING_16),
        shape: const StadiumBorder(),
        backgroundColor: color,
      ),
      child: Text(
        text,
      ),
    ),
  );
}
