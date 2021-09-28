import 'package:covidsmallapp/screen/home/component/prevetion/prevention_item.dart';
import 'package:flutter/material.dart';

class Prevention extends StatelessWidget {
  const Prevention({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PreventionItem(image: 'assets/images/image1.PNG',
          text: 'Avoid close contact',),
        PreventionItem(image: 'assets/images/image2.PNG',
          text: 'Clean your hands often',),
        PreventionItem(image: 'assets/images/image3.PNG',
          text: 'Wear a facemask',)
      ],
    );
  }
}
