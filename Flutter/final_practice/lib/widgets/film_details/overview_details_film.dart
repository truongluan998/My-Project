import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../constants/constants.dart';
import '../../dependencies/app_dependencies.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/film_details.dart';
import '../../utility/utility.dart';
import '../general/default_shimmer.dart';
import '../general/image_error.dart';
import '../general/view_all_text.dart';

class OverviewDetailsFilm extends StatefulWidget {
  const OverviewDetailsFilm({
    required this.filmDetails,
    Key? key,
  }) : super(key: key);

  final FilmDetails filmDetails;

  @override
  State<OverviewDetailsFilm> createState() => _OverviewDetailsFilmState();
}

class _OverviewDetailsFilmState extends State<OverviewDetailsFilm> {
  late final Utils _utils;

  @override
  void initState() {
    _utils = AppDependencies.injector.get<Utils>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DimensionConstant.PADDING_16,
        ),
        child: Column(
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  width: DimensionConstant.WIDTH_139,
                  height: DimensionConstant.HEIGHT_180,
                  imageUrl: '${PathConstant.DEFAULT_URL_IMAGE}'
                      '${widget.filmDetails.posterPath}',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => DefaultShimmer(
                    widget: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => const ImageError(),
                ),
                const SizedBox(width: DimensionConstant.WIDTH_16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.filmDetails.title ?? '',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: DimensionConstant.HEIGHT_4,
                      ),
                      Text(
                        _utils.convertGenresData(
                          widget.filmDetails.genres,
                        ),
                      ),
                      const SizedBox(
                        height: DimensionConstant.HEIGHT_8,
                      ),
                      AbsorbPointer(
                        child: Row(
                          children: [
                            RatingBar.builder(
                              initialRating: widget.filmDetails.voteAverage! /
                                  DimensionConstant.OFF_SET_2,
                              itemPadding: const EdgeInsets.only(
                                right: DimensionConstant.PADDING_4,
                              ),
                              allowHalfRating: true,
                              itemSize: DimensionConstant.SIZE_24,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (value) {},
                            ),
                            Expanded(
                              child: Text(
                                '${widget.filmDetails.voteAverage! / DimensionConstant.OFF_SET_2} / ${LabelConstant.FIVE}',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: DimensionConstant.HEIGHT_8,
                      ),
                      Text(
                        '${LabelConstant.LANGUAGE}'
                        '${widget.filmDetails.spokenLanguages!.isNotEmpty
                            ? widget.filmDetails.spokenLanguages!.first.name
                            ?? ''
                            : ''}',
                      ),
                      const SizedBox(
                        height: DimensionConstant.HEIGHT_8,
                      ),
                      Text(widget.filmDetails.releaseDate ?? '')
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: DimensionConstant.HEIGHT_8),
            ViewAllText(text: widget.filmDetails.overview ?? ''),
          ],
        ),
      );
}
