import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import 'card_item_in_search_multi.dart';

class CustomListViewItemInSearch extends StatelessWidget {
  const CustomListViewItemInSearch({
    required this.listResult,
    this.showGenres = true,
    Key? key,
  }) : super(key: key);

  final List<Results> listResult;
  final bool showGenres;

  @override
  Widget build(BuildContext context) => ListView.builder(
        padding: const EdgeInsets.all(DimensionConstant.PADDING_8),
        itemCount: listResult.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var genreConcat = '';
          if (listResult[index].genreNames != null) {
            genreConcat = listResult[index].genreNames!.join(' | ');
          }
          return CardItemInSearchMulti(
            results: listResult[index],
            showGenres: showGenres,
            genreConcat: genreConcat,
          );
        },
      );
}
