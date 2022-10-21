import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/tmdb_movie/genre/genre_list_bloc/genre_list_bloc.dart';
import '../../blocs/tmdb_movie/genre/genre_list_bloc/genre_list_event.dart';
import '../../blocs/tmdb_movie/genre/genre_list_bloc/genre_list_state.dart';
import '../../blocs/tmdb_movie/genre/movie_in_by_genre_bloc/movie_in_by_genre_bloc.dart';
import '../../blocs/tmdb_movie/genre/movie_in_by_genre_bloc/movie_in_by_genre_event.dart';
import '../../config/size_config.dart';
import '../../constants/constants.dart';
import '../../dependencies/app_dependencies.dart';
import '../../theme/final_practice_color.dart';
import '../../widgets/general/check_internet_and_click_to_refresh.dart';
import '../../widgets/general/custom_appbar.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({Key? key}) : super(key: key);

  static const String routeName = '/genres';

  static Route route() => MaterialPageRoute(
        builder: (_) => const GenresScreen(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen>
    with AutomaticKeepAliveClientMixin {
  late final GenreListBloc _genreListBloc;
  late final MovieInByGenreBloc _movieInByGenreBloc;

  @override
  void initState() {
    _genreListBloc = AppDependencies.injector.get<GenreListBloc>();
    _movieInByGenreBloc = AppDependencies.injector.get<MovieInByGenreBloc>();
    _getDataGenresInAPI();
    super.initState();
  }

  void _getDataGenresInAPI() {
    _genreListBloc.add(GetGenreListEvent());
  }

  Future<void> _pullToRefresh() async {
    _getDataGenresInAPI();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(text: LabelConstant.GENRES, press: () {}),
        body: RefreshIndicator(
          onRefresh: _pullToRefresh,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: FinalPracticeColor.backgroundScaffoldColor,
            child: BlocBuilder(
              bloc: _genreListBloc,
              builder: (context, state) {
                if (state is GenreListLoadingState) {
                  return const Center(
                    child: Text(LabelConstant.LOADING),
                  );
                }
                if (state is GenreListSuccessState) {
                  return ListView.builder(
                    itemCount: state.genreList!.genres!.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: DimensionConstant.PADDING_16,
                      ),
                      child: InkWell(
                        onTap: () {
                          _movieInByGenreBloc.add(
                            GetMovieInByGenreEvent(
                              genreId: state.genreList!.genres![index].id!,
                            ),
                          );
                          Navigator.pushNamed(
                            context,
                            '/movie_in_by_genre',
                            arguments: {
                              'arguments':
                                  state.genreList!.genres![index].name ?? '',
                              'genres_id': state.genreList!.genres![index].id
                            },
                          );
                        },
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.asset(
                              '${PathConstant.BACKGROUND_GENRE}$index.jpg',
                              height: SizeConfig.screenHeight *
                                  DimensionConstant.HEIGHT_0_DOT_25,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              width: double.infinity,
                              height: SizeConfig.screenHeight *
                                  DimensionConstant.HEIGHT_0_DOT_06,
                              color: Colors.white.withOpacity(
                                DimensionConstant.OPACITY_0_DOT_5,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: DimensionConstant.PADDING_20,
                                  ),
                                  child: Text(
                                    state.genreList!.genres![index].name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: FinalPracticeColor
                                              .textBlackLightColor,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                if (state is GenreListFailState) {
                  return CheckInternetAndClickToRefresh(
                    press: _pullToRefresh,
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      );

  @override
  bool get wantKeepAlive => true;
}
