import 'package:flutter/material.dart';

import '../../theme/final_practice_color.dart';

class ImageError extends StatelessWidget {
  const ImageError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>  Container(
    color: FinalPracticeColor.brownLightColor,
    width: 113,
    child: const Icon(
      Icons.error,
      color: Colors.black,
    ),
  );
}