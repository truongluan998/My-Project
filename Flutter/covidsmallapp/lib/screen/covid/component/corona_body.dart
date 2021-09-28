import 'package:covidsmallapp/component/header.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _buttonSelected = false;
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding * 1.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(),
                buildTitle('Statistics', Colors.white),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(defaultPadding * 2))
                  ),
                  child: Row(
                    children: [
                      MaterialButton(onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))
                      ),
                        color: Colors.white,
                        child: Text('My Country'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
