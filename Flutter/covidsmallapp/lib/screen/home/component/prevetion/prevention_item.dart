import 'package:flutter/material.dart';

import '../../../../constants.dart';

class PreventionItem extends StatelessWidget {
  const PreventionItem({
    Key? key, required this.image, required this.text,
  }) : super(key: key);

  final String image, text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.29,
      child: Column(
        children: [
          Image.asset(image, width: 120, height: 120,),
          SizedBox(height: defaultPadding / 2,),
          Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600
            ),
          )
        ],
      ),
    );
  }
}
