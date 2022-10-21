import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class AuthenMethodTitle extends StatelessWidget {
  const AuthenMethodTitle({
    required this.title,
    this.flex = 1,
    Key? key,
  }) : super(key: key);

  final String title;
  final int flex;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           const Expanded(
            child: Divider(
              color: Colors.white38,
              thickness: DimensionConstant.THICKNESS_2,
            ),
          ),
          Expanded(
            flex: flex,
            child: Center(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(height: DimensionConstant.HEIGHT_0_DOT_5),
              ),
            ),
          ),
          const Expanded(
            child: Divider(
              color: Colors.white38,
              thickness: DimensionConstant.THICKNESS_2,
            ),
          ),
        ],
      );
}
