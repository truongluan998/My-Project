import 'package:final_practice/blocs/tmdb_movie/details/film/reviews/review_of_film_event.dart';
import 'package:final_practice/model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/tmdb_movie/details/film/reviews/review_of_film_bloc.dart';
import '../../../blocs/tmdb_movie/details/film/reviews/reviews_of_film_state.dart';
import '../../../config/size_config.dart';
import '../../../constants/constants.dart';
import '../../../dependencies/app_dependencies.dart';
import '../../../widgets/film_details/reviews/info_reviewer.dart';
import '../../../widgets/general/text_notification.dart';
import '../../../widgets/general/view_all_text.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({
    required this.filmId,
    required this.type,
    Key? key,
  }) : super(key: key);

  final int filmId;
  final MediaType type;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen>
    with AutomaticKeepAliveClientMixin {
  late final ReviewOfFilmBloc _reviewOfMovieBloc;

  @override
  void initState() {
    _reviewOfMovieBloc = AppDependencies.injector.get<ReviewOfFilmBloc>();
    getReviewsOfFilm();
    super.initState();
  }

  void getReviewsOfFilm() {
    if (widget.type == MediaType.movie) {
      _reviewOfMovieBloc.add(GetReviewsOfMovieEvent(movieId: widget.filmId));
    } else {
      _reviewOfMovieBloc.add(GetReviewsOfTvShowEvent(tvShowId: widget.filmId));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder(
          bloc: _reviewOfMovieBloc,
          builder: (context, state) {
            if (state is GetReviewsOfFilmLoadingState) {
              return const TextNotification(
                text: LabelConstant.LOADING,
              );
            }
            if (state is GetReviewsOfFilmSuccessState) {
              return ListView.builder(
                itemCount: state.reviewsOfFilm!.results!.length,
                padding: const EdgeInsets.all(DimensionConstant.PADDING_12),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) => Card(
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.all(
                        DimensionConstant.PADDING_12,
                      ),
                      width: SizeConfig.screenWidth * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoReviewer(
                            index: index,
                            reviews: state.reviewsOfFilm!,
                          ),
                          const SizedBox(
                            height: DimensionConstant.HEIGHT_16,
                          ),
                          ViewAllText(
                            text:
                                state.reviewsOfFilm!.results![index].content ??
                                    '',
                          ),
                          const SizedBox(
                            height: DimensionConstant.HEIGHT_16,
                          ),
                          Row(
                            children: [
                              Image.asset(PathConstant.FACEBOOK_LIKED_ICON),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  LabelConstant.HELPFUL,
                                  style: TextStyle(
                                    fontSize: DimensionConstant.FONT_SIZE_15,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      );

  @override
  bool get wantKeepAlive => true;
}
