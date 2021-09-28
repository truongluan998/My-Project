import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    Key? key, required this.name, required this.property, required this.icon,
  }) : super(key: key);

  final String name, property;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),),
          Container(
            child: Row(
              children: [
                Text(property, style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400
                ),),
                const SizedBox(width: 5,),
                Icon(icon, color: kSecondaryColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
