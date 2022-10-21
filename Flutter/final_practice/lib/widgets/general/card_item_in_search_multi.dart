import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../blocs/tmdb_movie/details/artists/overview_details/artists_details_bloc.dart';
import '../../blocs/tmdb_movie/details/artists/overview_details/artists_details_event.dart';
import '../../constants/constants.dart';
import '../../dependencies/app_dependencies.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../../theme/final_practice_color.dart';
import 'custom_border_radius_image.dart';

class CardItemInSearchMulti extends StatefulWidget {
  const CardItemInSearchMulti({
    required this.results,
    required this.showGenres,
    this.genreConcat,
    Key? key,
  }) : super(key: key);

  final Results results;
  final bool showGenres;
  final String? genreConcat;

  @override
  State<CardItemInSearchMulti> createState() => _CardItemInSearchMultiState();
}

class _CardItemInSearchMultiState extends State<CardItemInSearchMulti> {
  late final ArtistsDetailsBloc _artistsDetailsBloc;

  @override
  void initState() {
    _artistsDetailsBloc = AppDependencies.injector.get<ArtistsDetailsBloc>();
    super.initState();
  }

  void _callApiDetailsArtists() {
    _artistsDetailsBloc
        .add(ShowDetailsOfArtistsEvent(artistsId: widget.results.id!));
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          if (widget.results.mediaType == 'movie') {
            Navigator.pushNamed(
              context,
              '/film_details',
              arguments: {
                'film_id': widget.results.id!,
                'type': MediaType.movie
              },
            );
          }
          if (widget.results.mediaType == 'tv') {
            Navigator.pushNamed(
              context,
              '/film_details',
              arguments: {'film_id': widget.results.id!, 'type': MediaType.tv},
            );
          }
          if (widget.results.mediaType == 'person') {
            _callApiDetailsArtists();
            Navigator.pushNamed(
              context,
              '/artists_details',
              arguments: {'artists_id': widget.results.id!},
            );
          }
        },
        child: Card(
          color: FinalPracticeColor.whiteColor,
          elevation: DimensionConstant.ELEVATION_0,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                CustomBorderRadiusImage(
                  url: widget.results.posterPath ?? '',
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    DimensionConstant.PADDING_8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.results.name ?? '',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Visibility(
                              visible: widget.showGenres,
                              child: Text(
                                widget.genreConcat ?? '',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: DimensionConstant.WIDTH_24),
                      AbsorbPointer(
                        child: RatingBar.builder(
                          initialRating: widget.results.voteAverage! /
                              DimensionConstant.OFF_SET_2,
                          itemPadding: const EdgeInsets.symmetric(
                            horizontal: DimensionConstant.PADDING_2,
                          ),
                          allowHalfRating: true,
                          itemSize: DimensionConstant.SIZE_24,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (value) {},
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
