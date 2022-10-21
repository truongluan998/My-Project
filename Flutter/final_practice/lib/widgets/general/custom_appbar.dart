import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    required this.text,
    required this.press,
    Key? key,
  }) : super(key: key);

  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) => AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          IconButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: DimensionConstant.HEIGHT_32,
            ),
          )
        ],
      );

  @override
  Size get preferredSize =>
      const Size.fromHeight(DimensionConstant.DEFAULT_HEIGHT_APP_BAR);
}
