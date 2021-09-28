import 'package:covidsmallapp/screen/home/component/prevetion/prevention.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import 'banner.dart';

class CovidPrevention extends StatelessWidget {
  const CovidPrevention({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildTitle('Prevention', Colors.black),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            Prevention(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
            HomeBanner()
          ],
        ),
      ),
    );
  }
}
