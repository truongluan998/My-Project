import 'package:flutter/material.dart';
import '../../const/constants.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    required this.paddingLeft,
    required this.paddingRight,
    Key? key,
  }) : super(key: key);

  final double paddingLeft;
  final double paddingRight;

  @override
  Widget build(BuildContext context) => TextButton.icon(
        onPressed: () {},
        icon: const Icon(
          Icons.play_arrow,
          size: DimensionConstant.SIZE_28,
          color: Colors.black,
        ),
        label: const Text(
          LabelConstant.PLAY,
          style: TextStyle(
            fontSize: DimensionConstant.FONT_SIZE_16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.only(
              left: paddingLeft,
              right: paddingRight,
            ),
          ),
        ),
      );
}
