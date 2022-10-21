import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../constants/constants.dart';
import '../../../dependencies/app_dependencies.dart';
import '../../../model/tmdb_movie/general_movie_tv_show_and_artsits/reviews_of_film.dart';
import '../../../theme/final_practice_color.dart';
import '../../../utility/utility.dart';
import 'reviews_circle_avatar.dart';

class InfoReviewer extends StatefulWidget {
  const InfoReviewer({
    required this.reviews,
    required this.index,
    Key? key,
  }) : super(key: key);

  final ReviewsOfFilm reviews;
  final int index;

  @override
  State<InfoReviewer> createState() => _InfoReviewerState();
}

class _InfoReviewerState extends State<InfoReviewer> {
  late final Utils _utils;

  @override
  void initState() {
    _utils = AppDependencies.injector.get<Utils>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReviewCircleAvatar(
            pathImage: widget
                    .reviews.results![widget.index].authorDetails!.avatarPath ??
                '',
          ),
          const SizedBox(
            width: DimensionConstant.WIDTH_12,
          ),
          Flexible(
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.reviews.results![widget.index].author ?? '',
                            style: Theme.of(context).textTheme.bodyText1,
                            maxLines: DimensionConstant.MAX_LINE_1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: DimensionConstant.HEIGHT_8,
                          ),
                          Text(
                            _utils.convertTime(
                              widget.reviews.results![widget.index].createdAt ??
                                  '',
                            ),
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: DimensionConstant.WIDTH_12,
                    ),
                    AbsorbPointer(
                      child: Row(
                        children: [
                          RatingBar.builder(
                            initialRating: widget.reviews.results![widget.index]
                                    .authorDetails!.rating ??
                                DimensionConstant.OFF_SET_0 /
                                    DimensionConstant.OFF_SET_2,
                            itemPadding: const EdgeInsets.only(
                              right: DimensionConstant.PADDING_4,
                            ),
                            allowHalfRating: true,
                            itemSize: DimensionConstant.SIZE_18,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (value) {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: DimensionConstant.HEIGHT_8,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Divider(
                    color: FinalPracticeColor.brownLightColor,
                    thickness: DimensionConstant.OFF_SET_2,
                  ),
                )
              ],
            ),
          ),
        ],
      );
}
