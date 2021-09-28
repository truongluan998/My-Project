import 'package:covidsmallapp/component/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ContactMethod extends StatelessWidget {
  const ContactMethod({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('Are you feeling sick?', Colors.white),
        SizedBox(height: defaultPadding,),
        Text(
          'If you feel sick with any of covid-19 symptoms please call or SMS us immediately for help.',
          style: TextStyle(color: secondaryColor, fontSize: 10),
        ),
        SizedBox(height: defaultPadding * 1.5,),
        Row(
          children: [
            PrimaryButton(text: 'Call Now', icon: Icons.phone,
              color: Color(0xFFFF4D58), press: () {},),
            Spacer(),
            PrimaryButton(text: 'Send SMS', icon: Icons.messenger,
                color: Color(0xFF4D79FF) ,press: () {})
          ],
        )
      ],
    );
  }
}
