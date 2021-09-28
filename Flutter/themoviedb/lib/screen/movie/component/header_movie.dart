import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class HeaderMovie extends StatelessWidget {
  const HeaderMovie({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
                text: 'Browse\n',
                style: headingStyle,
                children:[
                  TextSpan(text: 'Movies in Chennai', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200
                  )),
                  WidgetSpan(child: Icon(Icons.arrow_drop_down_outlined, color: kSecondaryColor,))
                ]
            ),
          ),
          SizedBox(
            child: Container(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/circle_avatar.jpg'),
                  ),
                  const SizedBox(width: 5,),
                  Icon(Icons.format_align_right_sharp)
                ],
              ),
            ),

          )
        ],
      ),
    );
  }
}
