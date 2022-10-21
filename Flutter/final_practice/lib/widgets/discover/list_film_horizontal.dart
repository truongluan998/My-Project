import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../general/card_item_film.dart';

class ListFilmHorizontal extends StatelessWidget {
  const ListFilmHorizontal({
    required this.title,
    required this.press,
    this.data,
    Key? key,
  }) : super(key: key);

  final String title;
  final TMDBData? data;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const Spacer(),
              TextButton(
                onPressed: press,
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  LabelConstant.SEE_ALL,
                  style: TextStyle(fontSize: DimensionConstant.FONT_SIZE_16),
                ),
              ),
              Icon(
                Icons.navigate_next,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: DimensionConstant.HEIGHT_6),
            ],
          ),
          const SizedBox(height: DimensionConstant.HEIGHT_6),
          SizedBox(
            height: DimensionConstant.HEIGHT_250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data!.results!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(
                  right: DimensionConstant.PADDING_6,
                ),
                child: CardItemsFilm(
                  results: data!.results![index],
                  type: data!.type,
                ),
              ),
            ),
          )
        ],
      );
}
