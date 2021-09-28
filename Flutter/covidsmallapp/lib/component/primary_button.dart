import 'package:flutter/material.dart';

import '../constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key, required this.text, required this.press, this.color, required this.icon,
  }) : super(key: key);

  final String text;
  final VoidCallback press;
  final color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: press, shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(40)),
    ),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding * 0.75),
        child: Row(
          children: [
            Icon(icon, color: Colors.white,),
            SizedBox(width: defaultPadding / 2,),
            Text(text, style: TextStyle(
              color: Colors.white,
            ),)
          ],
        ),
      ),
    );
  }
}
