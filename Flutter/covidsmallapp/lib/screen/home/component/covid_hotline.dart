import 'package:covidsmallapp/component/header.dart';
import 'package:covidsmallapp/component/primary_button.dart';
import 'package:covidsmallapp/screen/home/component/select_country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'contact_method.dart';

class CovidHotLine extends StatelessWidget {
  const CovidHotLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(defaultPadding * 3),
            bottomLeft: Radius.circular(defaultPadding * 3),
          )),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding * 1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Header(),
            SelectCountry(),
            ContactMethod()
          ],
        ),
      ),
    );
  }
}


