import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class TabMoreInformation extends StatelessWidget {
  const TabMoreInformation({
    required this.tabPages,
    required this.heightOfTab,
    required this.textTabOne,
    required this.textTabTwo,
    required this.textTabThree,
    Key? key,
  }) : super(key: key);

  final List<Widget> tabPages;
  final double heightOfTab;
  final String textTabOne;
  final String textTabTwo;
  final String textTabThree;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: heightOfTab,
        child: Column(
          children: [
            SizedBox(
              height: DimensionConstant.HEIGHT_60,
              child: TabBar(
                labelColor: Theme.of(context).primaryColor,
                tabs: [
                  Tab(text: textTabOne),
                  Tab(text: textTabTwo),
                  Tab(text: textTabThree),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: tabPages,
              ),
            ),
          ],
        ),
      );
}
