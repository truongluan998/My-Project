import 'package:final_practice/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ViewAllText extends StatelessWidget {
  const ViewAllText({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) => ReadMoreText(
    text,
    trimLines: DimensionConstant.MAX_LINE_3,
    trimMode: TrimMode.Line,
    trimCollapsedText: LabelConstant.VIEW_ALL,
    trimExpandedText: LabelConstant.VIEW_LESS,
    delimiter: '',
    style: Theme.of(context).textTheme.bodyText2,
  );
}
