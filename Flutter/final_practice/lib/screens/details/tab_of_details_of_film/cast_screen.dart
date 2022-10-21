import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/tmdb_movie/details/film/cast/cast_of_film_bloc.dart';
import '../../../blocs/tmdb_movie/details/film/cast/cast_of_film_event.dart';
import '../../../blocs/tmdb_movie/details/film/cast/cast_of_film_state.dart';
import '../../../constants/constants.dart';
import '../../../dependencies/app_dependencies.dart';
import '../../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../../../widgets/general/card_item_artists.dart';
import '../../../widgets/general/text_notification.dart';

class CastScreen extends StatefulWidget {
  const CastScreen({
    required this.filmId,
    required this.type,
    Key? key,
  }) : super(key: key);

  final int filmId;
  final MediaType type;

  @override
  State<CastScreen> createState() => _CastScreenState();
}

class _CastScreenState extends State<CastScreen>
    with AutomaticKeepAliveClientMixin {
  late final CastOfFilmBloc _castOfFilmBloc;

  @override
  void initState() {
    _castOfFilmBloc = AppDependencies.injector.get<CastOfFilmBloc>();
    getCastOfFilm();
    super.initState();
  }

  void getCastOfFilm() {
    if (widget.type == MediaType.movie) {
      _castOfFilmBloc.add(GetCastOfMovieEvent(movieId: widget.filmId));
    } else {
      _castOfFilmBloc.add(GetCastOfTvShowEvent(tvShowId: widget.filmId));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder(
          bloc: _castOfFilmBloc,
          builder: (context, state) {
            if (state is GetCastOfFilmLoadingState) {
              return const TextNotification(
                text: LabelConstant.LOADING,
              );
            }
            if (state is GetCastOfFilmSuccessState) {
              return SizedBox(
                height: DimensionConstant.HEIGHT_290,
                child: ListView.builder(
                  padding: const EdgeInsets.all(DimensionConstant.PADDING_12),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.castOfFilm!.results!.length,
                  itemBuilder: (context, index) => CardItemArtists(
                    resList: state.castOfFilm!.results![index],
                    width: DimensionConstant.WIDTH_158,
                    maxLine: DimensionConstant.MAX_LINE_1,
                  ),
                ),
              );
            }
            if (state is GetCastOfFilmFailState) {
              return const TextNotification(
                text: LabelConstant.SOMETHING_WRONG,
              );
            }
            return const Center(
              child: Text(LabelConstant.NO_DATA),
            );
          },
        ),
      );

  @override
  bool get wantKeepAlive => true;
}
