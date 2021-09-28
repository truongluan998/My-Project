import 'package:flutter/material.dart';

import '../../../constants.dart';

class SelectCountry extends StatelessWidget {
  const SelectCountry({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Covid-19',
          style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(defaultPadding * 2))
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundImage:
                AssetImage('assets/images/flag_viet_nam.jpg'),
              ),
              SizedBox(width: defaultPadding / 2,),
              Text('VN', style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
              Icon(Icons.arrow_drop_down_rounded)
            ],
          ),
        )
      ],
    );
  }
}
