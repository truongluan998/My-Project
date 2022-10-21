import 'package:flutter/material.dart';

import '../../../const/constants.dart';
import '../../../models/content_model.dart';
import '../../../widgets/general/bottom_sheet_open_overview.dart';

class ListFilmHorizontal extends StatelessWidget {
  const ListFilmHorizontal({
    required this.title,
    required this.contentList,
    Key? key,
  }) : super(key: key);

  final String title;
  final List<Content> contentList;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: DimensionConstant.PADDING_16,),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          SizedBox(
            height: DimensionConstant.HEIGHT_200,
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                DimensionConstant.PADDING_16,
                DimensionConstant.PADDING_12,
                DimensionConstant.PADDING_8,
                DimensionConstant.PADDING_12,
              ),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: contentList.length,
              itemBuilder: (context, index) => BottomSheetOpenOverview(
                listContent: contentList,
                featuredContent: contentList[index],
                widget: Padding(
                  padding:
                      const EdgeInsets.only(right: DimensionConstant.PADDING_8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        DimensionConstant.BORDER_RADIUS_4,),
                    child: Image.asset(
                      contentList[index].imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );
}
