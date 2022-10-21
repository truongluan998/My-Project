import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/tmdb_movie/genre/movie_in_by_genre_bloc/movie_in_by_genre_bloc.dart';
import '../../blocs/tmdb_movie/genre/movie_in_by_genre_bloc/movie_in_by_genre_event.dart';
import '../../blocs/tmdb_movie/genre/movie_in_by_genre_bloc/movie_in_by_genre_state.dart';
import '../../constants/constants.dart';
import '../../dependencies/app_dependencies.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../../theme/final_practice_color.dart';
import '../../widgets/general/check_internet_and_click_to_refresh.dart';
import '../../widgets/general/custom_appbar.dart';
import '../../widgets/general/gridview_load_more_film.dart';

class MovieInByGenreScreen extends StatefulWidget {
  const MovieInByGenreScreen({Key? key}) : super(key: key);

  static const String routeName = '/movie_in_by_genre';

  static Route route() => MaterialPageRoute(
        builder: (_) => const MovieInByGenreScreen(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  _MovieInByGenreScreenState createState() => _MovieInByGenreScreenState();
}

class _MovieInByGenreScreenState extends State<MovieInByGenreScreen> {
  late final MovieInByGenreBloc _movieInByGenreBloc;
  final ScrollController _scrollController = ScrollController();
  static const double _endReachedThreshold = 0;
  late List<Results> resList = [];
  late int genresId;

  void _onScrollToLoadMoreMovie() {
    if (_scrollController.position.extentAfter == _endReachedThreshold) {
      _getDataFilmInAPI();
    }
  }

  void _getDataFilmInAPI() {
    _movieInByGenreBloc.add(GetMovieInByGenreEvent(genreId: genresId));
  }

  Future<void> _pullToRefresh() async {
    _getDataFilmInAPI();
  }

  @override
  void initState() {
    _movieInByGenreBloc = AppDependencies.injector.get<MovieInByGenreBloc>();
    _scrollController.addListener(_onScrollToLoadMoreMovie);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments! as Map;
    genresId = arguments['genres_id'];
    _movieInByGenreBloc.add(GetMovieInByGenreEvent(genreId: genresId));
    return Scaffold(
      appBar: CustomAppBar(
        press: () {},
        text: arguments['arguments'],
      ),
      body: RefreshIndicator(
        onRefresh: _pullToRefresh,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: FinalPracticeColor.backgroundScaffoldColor,
          padding: const EdgeInsets.only(
            left: DimensionConstant.PADDING_16,
            right: DimensionConstant.PADDING_16,
            bottom: DimensionConstant.PADDING_8,
          ),
          child: BlocBuilder(
            bloc: _movieInByGenreBloc,
            builder: (context, state) {
              if (state is MovieInByGenreSuccessState) {
                resList.addAll(state.movieInByGenreList!);
                return GridViewLoadMoreFilm(
                  resList: resList,
                  scrollController: _scrollController,
                );
              }
              if (state is MovieInByGenreFailState) {
                return CheckInternetAndClickToRefresh(
                  press: _pullToRefresh,
                );
              }
              return const Center(
                child: Text(LabelConstant.LOADING),
              );
            },
          ),
        ),
      ),
    );
  }
}
