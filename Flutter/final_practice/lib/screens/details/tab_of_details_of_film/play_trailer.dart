import 'package:after_layout/after_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../blocs/tmdb_movie/details/film/trailer/trailer_of_film_bloc.dart';
import '../../../blocs/tmdb_movie/details/film/trailer/trailer_of_film_event.dart';
import '../../../blocs/tmdb_movie/details/film/trailer/trailer_of_film_state.dart';
import '../../../constants/constants.dart';
import '../../../dependencies/app_dependencies.dart';
import '../../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../../../widgets/general/custom_appbar.dart';
import '../../../widgets/general/text_notification.dart';

class PlayTrailer extends StatefulWidget {
  const PlayTrailer({Key? key}) : super(key: key);

  static const String routeName = '/play_trailer';

  static Route route() => MaterialPageRoute(
        builder: (_) => const PlayTrailer(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  _PlayTrailerState createState() => _PlayTrailerState();
}

class _PlayTrailerState extends State<PlayTrailer> with AfterLayoutMixin {
  late String _initialVideoId;
  late final YoutubePlayerController _youtubePlayerController;
  late final TrailerOfFilmBloc _trailerOfFilmBloc;
  late int filmId;
  late MediaType _type;

  @override
  void initState() {
    _trailerOfFilmBloc = AppDependencies.injector.get<TrailerOfFilmBloc>();
    super.initState();
  }

  void _playTrailer() {
    if(_type == MediaType.movie) {
      _trailerOfFilmBloc.add(GetTrailerOfMovieEvent(movieId: filmId));
    } else {
      _trailerOfFilmBloc.add(GetTrailerOfTvShowEvent(tvShowId: filmId));
    }
  }

  @override
  void dispose() {
    _youtubePlayerController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments! as Map;
    filmId = arguments['film_id'];
    _type = arguments['type'];

    return Scaffold(
        appBar: CustomAppBar(
          press: () {},
          text: 'Trailer Film',
        ),
        body: BlocBuilder(
          bloc: _trailerOfFilmBloc,
          builder: (context, state) {
            if (state is GetTrailerOfFilmLoadingState) {
              return const TextNotification(
                text: LabelConstant.LOADING,
              );
            }
            if (state is GetTrailerOfFilmSuccessState) {
              _initialVideoId = state.trailerOfFilm!.results!.isNotEmpty
                  ? state.trailerOfFilm!.results![0].key ?? ''
                  : '';
              _youtubePlayerController = YoutubePlayerController.fromVideoId(
              videoId: 'https://www.youtube.com/watch?v=$_initialVideoId',
            );
            return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: YoutubePlayer(
                  controller: _youtubePlayerController,
                  aspectRatio: 16 / 9,
                ),
              );
            }
            if (state is GetTrailerOfFilmFailState) {
              return TextNotification(
                text: state.message,
              );
            }
            return Container();
          },
        ),
      );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _playTrailer();
  }
}
