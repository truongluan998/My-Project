import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../const/constants.dart';

class VerticalIconButton extends StatelessWidget {
  const VerticalIconButton({
    required this.icon,
    required this.title,
    required this.press,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: press,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(
              height: DimensionConstant.HEIGHT_2,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: DimensionConstant.FONT_SIZE_11,
                    fontWeight: FontWeight.normal,
                  ),
            )
          ],
        ),
      );
}
