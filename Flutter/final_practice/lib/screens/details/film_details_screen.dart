import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/tmdb_movie/details/film/favorite/save_favorite_film_to_firebase_bloc.dart';
import '../../blocs/tmdb_movie/details/film/favorite/save_favorite_film_to_firebase_event.dart';
import '../../blocs/tmdb_movie/details/film/favorite/save_favorite_film_to_firebase_state.dart';
import '../../blocs/tmdb_movie/details/film/overview_details/film_details_bloc.dart';
import '../../blocs/tmdb_movie/details/film/overview_details/film_details_event.dart';
import '../../blocs/tmdb_movie/details/film/overview_details/film_details_state.dart';
import '../../config/size_config.dart';
import '../../constants/constants.dart';
import '../../dependencies/app_dependencies.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/film_details.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../../utility/utility.dart';
import '../../widgets/film_details/background_image.dart';
import '../../widgets/film_details/hightlight_in_bottom_main_image.dart';
import '../../widgets/film_details/icon_play_video.dart';
import '../../widgets/film_details/overview_details_film.dart';
import '../../widgets/general/appbar_details_screen.dart';
import '../../widgets/general/tab_more_information_of_film.dart';
import '../../widgets/general/text_notification.dart';
import 'tab_of_details_of_film/cast_screen.dart';
import 'tab_of_details_of_film/more_screen.dart';
import 'tab_of_details_of_film/reviews_screen.dart';

class FilmDetailsScreen extends StatefulWidget {
  const FilmDetailsScreen({Key? key}) : super(key: key);

  static const String routeName = '/film_details';

  static Route route() => MaterialPageRoute(
        builder: (_) => const FilmDetailsScreen(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  _FilmDetailsScreenState createState() => _FilmDetailsScreenState();
}

class _FilmDetailsScreenState extends State<FilmDetailsScreen>
    with AfterLayoutMixin {
  late final Utils _utils;
  late final FilmDetailsBloc _filmDetailsBloc;

  late final StoreFavoriteFilmToFirebaseBloc _storeFavoriteFilmToFirebaseBloc;
  late int filmId;
  late MediaType _type;

  bool _isFavorite = false;
  late final FilmDetails _filmData;

  @override
  void initState() {
    _utils = AppDependencies.injector.get<Utils>();
    _filmDetailsBloc = AppDependencies.injector.get<FilmDetailsBloc>();
    _storeFavoriteFilmToFirebaseBloc =
        AppDependencies.injector.get<StoreFavoriteFilmToFirebaseBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments! as Map;
    filmId = arguments['film_id'];
    _type = arguments['type'];
    final _tabPages = <Widget>[
      CastScreen(
        filmId: filmId,
        type: _type,
      ),
      ReviewsScreen(
        filmId: filmId,
        type: _type,
      ),
      const MoreScreen(),
    ];

    return DefaultTabController(
      length: _tabPages.length,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBarDetailsScreen(
          action: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: BlocBuilder(
                bloc: _storeFavoriteFilmToFirebaseBloc,
                builder: (context, state) {
                  if (state is FavoriteFilmState) {
                    _isFavorite = true;
                  }
                  if (state is NormalFilmState) {
                    _isFavorite = false;
                  }
                  return IconButton(
                    padding: const EdgeInsets.only(bottom: 16),
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                      if (_isFavorite == false) {
                        _storeFavoriteFilmToFirebaseBloc.add(
                          SaveToFavoriteListEvent(
                            results: _filmData,
                            mediaType: _type,
                          ),
                        );
                      } else {
                        _storeFavoriteFilmToFirebaseBloc.add(
                          RemoveFromFavoriteListEvent(filmId: filmId),
                        );
                      }
                    },
                    icon: Icon(
                      Icons.favorite,
                      size: DimensionConstant.SIZE_48,
                      color: _isFavorite ? Colors.blue : Colors.white,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        body: BlocBuilder(
          bloc: _filmDetailsBloc,
          builder: (context, state) {
            if (state is ShowFilmDetailsLoadingState) {
              const TextNotification(text: LabelConstant.LOADING);
            }
            if (state is ShowFilmDetailsSuccessState) {
              _filmData = state.movieDetails!;
              return SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        child: Stack(
                          children: [
                            BackgroundImage(
                              imagePath: state.movieDetails!.posterPath ?? '',
                              heightOfImage: SizeConfig.screenHeight *
                                  DimensionConstant.HEIGHT_0_DOT_35,
                            ),
                            const HighlightInBottomMainImage(),
                            IconPlayVideo(
                              press: () {
                                if (_type == MediaType.movie) {
                                  Navigator.pushNamed(
                                    context,
                                    '/play_trailer',
                                    arguments: {
                                      'film_id': filmId,
                                      'type': MediaType.movie
                                    },
                                  );
                                }
                                if (_type == MediaType.tv) {
                                  Navigator.pushNamed(
                                    context,
                                    '/play_trailer',
                                    arguments: {
                                      'film_id': filmId,
                                      'type': MediaType.tv
                                    },
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      OverviewDetailsFilm(filmDetails: state.movieDetails!),
                      TabMoreInformation(
                        tabPages: _tabPages,
                        heightOfTab: DimensionConstant.HEIGHT_320,
                        textTabOne: LabelConstant.CAST,
                        textTabTwo: LabelConstant.REVIEWS,
                        textTabThree: LabelConstant.MORE,
                      )
                    ],
                  ),
                ),
              );
            }
            if (state is ShowFilmDetailsFailState) {
              return TextNotification(
                text: state.message,
              );
            }
            return const Center(
              child: Text(LabelConstant.LOADING),
            );
          },
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _storeFavoriteFilmToFirebaseBloc
        .add(CheckFavoriteFilmEvent(filmId: filmId));
    if (_type == MediaType.movie) {
      _filmDetailsBloc.add(ShowDetailsOfMovieEvent(movieId: filmId));
    } else {
      _filmDetailsBloc.add(ShowDetailsOfTvShowEvent(tvShowId: filmId));
    }
  }
}
