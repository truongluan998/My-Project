import 'package:flutter/material.dart';

import '../../../../constants.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius:
        BorderRadius.all(Radius.circular(defaultPadding)),
        gradient: LinearGradient(
          begin: Alignment(0.0, 0.0),
          end: Alignment.topLeft,
          colors: <Color>[primaryColor, Color(0xff968BD2)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/Asma_Khan.png',
              height: 96,
              width: 96,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitle('Do your own test!', Colors.white),
                    SizedBox(height: defaultPadding / 2,),
                    Text(
                      'Follow the instructions to do your own test.',
                      style: TextStyle(color: secondaryColor),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
