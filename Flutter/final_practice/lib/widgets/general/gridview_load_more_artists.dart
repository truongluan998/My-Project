import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../model/tmdb_movie/artists/person.dart';
import 'card_item_artists.dart';
import 'default_shimmer.dart';

class GridViewLoadMoreArtists extends StatelessWidget {
  const GridViewLoadMoreArtists({
    required this.resList,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  final ScrollController scrollController;
  final List<Results> resList;

  @override
  Widget build(BuildContext context) => GridView.builder(
        padding: const EdgeInsets.all(DimensionConstant.PADDING_16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: DimensionConstant.CROSS_AXIS_COUNT_3,
          childAspectRatio: DimensionConstant.CHILD_ASPECT_RATIO_0_DOT_47,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        controller: scrollController,
        itemCount: resList.length + 3,
        itemBuilder: (context, index) => (index >= resList.length)
            ? DefaultShimmer(
                widget: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                ),
              )
            : CardItemArtists(
                resList: resList[index],
                width: DimensionConstant.WIDTH_130,
                maxLine: DimensionConstant.MAX_LINE_2,
              ),
      );
}
