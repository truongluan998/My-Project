import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import 'card_item_film.dart';
import 'default_shimmer.dart';

class GridViewLoadMoreFilm extends StatelessWidget {
  const GridViewLoadMoreFilm({
    required this.resList,
    this.scrollController,
    Key? key,
  }) : super(key: key);

  final ScrollController? scrollController;
  final List<Results?> resList;

  @override
  Widget build(BuildContext context) => GridView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: DimensionConstant.PADDING_16,
        ),
        controller: scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: DimensionConstant.CROSS_AXIS_COUNT_2,
          childAspectRatio: DimensionConstant.CHILD_ASPECT_RATIO_0_DOT_74,
          crossAxisSpacing: DimensionConstant.CROSS_AXIS_SPACING_8,
          mainAxisSpacing: DimensionConstant.MAIN_AXIS_SPACING_8,
        ),
        itemCount: resList.length + 2,
        itemBuilder: (context, index) => (index >= resList.length)
            ? DefaultShimmer(
                widget: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                ),
              )
            : CardItemsFilm(
                results: resList[index],
              ),
      );
}
