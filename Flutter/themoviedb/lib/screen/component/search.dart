import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class Search extends StatelessWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),
      child: Container(
        height: 44,
        child: TextField(
          onChanged: (value) {},
          keyboardType: TextInputType.emailAddress,
          cursorColor: kTextColor,
          decoration: InputDecoration(
            // enabledBorder: InputBorder.none,
            // focusedBorder: InputBorder.none,
            hintText: 'Search movies or theatres',
            prefixIcon: Icon(Icons.search, color: kSecondaryColor,),
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(9)),
          ),
        ),
      ),
    );
  }
}
