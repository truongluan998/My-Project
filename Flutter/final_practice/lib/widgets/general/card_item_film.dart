import 'package:flutter/material.dart';

import '../../blocs/tmdb_movie/details/film/cast/cast_of_film_bloc.dart';
import '../../blocs/tmdb_movie/details/film/cast/cast_of_film_event.dart';
import '../../blocs/tmdb_movie/details/film/overview_details/film_details_bloc.dart';
import '../../blocs/tmdb_movie/details/film/overview_details/film_details_event.dart';
import '../../blocs/tmdb_movie/details/film/reviews/review_of_film_bloc.dart';
import '../../blocs/tmdb_movie/details/film/reviews/review_of_film_event.dart';
import '../../constants/constants.dart';
import '../../dependencies/app_dependencies.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../../theme/final_practice_color.dart';
import 'custom_border_radius_image.dart';

class CardItemsFilm extends StatelessWidget {
  const CardItemsFilm({
    this.type,
    this.results,
    Key? key,
  }) : super(key: key);

  final Results? results;
  final MediaType? type;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          if (type == MediaType.movie || results!.mediaType == 'movie') {
            Navigator.pushNamed(
              context,
              '/film_details',
              arguments: {'film_id': results!.id!, 'type': MediaType.movie},
            );
          }
          if (type == MediaType.tv || results!.mediaType == 'tv') {
            Navigator.pushNamed(
              context,
              '/film_details',
              arguments: {'film_id': results!.id!, 'type': MediaType.tv},
            );
          }
        },
        child: Card(
          color: FinalPracticeColor.whiteColor,
          elevation: DimensionConstant.ELEVATION_0,
          child: SizedBox(
            width: DimensionConstant.WIDTH_158,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBorderRadiusImage(url: results!.posterPath ?? ''),
                const SizedBox(height: DimensionConstant.HEIGHT_4),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimensionConstant.PADDING_8,
                  ),
                  child: Text(
                    results!.name ?? LabelConstant.NA,
                    textAlign: TextAlign.center,
                    maxLines: DimensionConstant.MAX_LINE_1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: DimensionConstant.HEIGHT_8),
              ],
            ),
          ),
        ),
      );
}
