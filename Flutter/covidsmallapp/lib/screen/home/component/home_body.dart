import 'package:covidsmallapp/constants.dart';
import 'package:covidsmallapp/screen/home/component/prevetion/banner.dart';
import 'package:covidsmallapp/screen/home/component/prevetion/prevention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'covid_hotline.dart';
import 'prevetion/covid_prevention.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CovidHotLine(),
          CovidPrevention()
        ],
      ),
    );
  }
}


