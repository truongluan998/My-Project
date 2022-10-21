import 'package:bloc/bloc.dart';

import '../../../../dependencies/app_dependencies.dart';
import '../../../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../../../../repository/api/tmdb_movie_repository.dart';
import 'movie_in_by_genre_event.dart';
import 'movie_in_by_genre_state.dart';

class MovieInByGenreBloc
    extends Bloc<MovieInByGenreEvent, MovieInByGenreState> {
  final TMDBMovieRepository tmdbMovieRepository;
  var _page = 0;
  bool _isLoading = false;

  MovieInByGenreBloc(this.tmdbMovieRepository)
      : super(MovieInByGenreInitial()) {
    on<GetMovieInByGenreEvent>((event, emit) async {
      if (!_isLoading) {
        try {
          _page++;
          final movieInByGenre =
              await tmdbMovieRepository.movieInByGenre(event.genreId, _page);
          final listFilmResponse = <Results>[];
          if (movieInByGenre != null && movieInByGenre.results != null) {
            for (var i = 0; i < movieInByGenre.results!.length; i++) {
              listFilmResponse.add(movieInByGenre.results![i]);
              listFilmResponse[i].mediaType = 'movie';
            }
            emit(
              MovieInByGenreSuccessState(
                movieInByGenreList: listFilmResponse,
              ),
            );
          } else {
            _page--;
            emit(
              MovieInByGenreFailState(message: 'Something Wrong! Try again.'),
            );
          }
        } on Exception catch (_) {
          _page--;
          emit(MovieInByGenreFailState(message: 'Something Wrong! Try again.'));
        }
        _isLoading = false;
      }
    });
  }
}
