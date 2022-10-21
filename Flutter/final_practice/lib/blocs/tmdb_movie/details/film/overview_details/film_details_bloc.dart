import 'package:bloc/bloc.dart';
import '../../../../../dependencies/app_dependencies.dart';
import '../../../../../repository/api/tmdb_movie_repository.dart';

import 'film_details_event.dart';
import 'film_details_state.dart';

class FilmDetailsBloc extends Bloc<FilmDetailsEvent, FilmDetailsState> {
  final TMDBMovieRepository tmdbMovieRepository;

  FilmDetailsBloc(this.tmdbMovieRepository) : super(ShowFilmDetailsInitial()) {
    on<ShowDetailsOfMovieEvent>((event, emit) async {
      emit(ShowFilmDetailsLoadingState());
      try {
        final movieDetails =
            await tmdbMovieRepository.getDetailsMovie(event.movieId);
        if (movieDetails != null) {
          emit(ShowFilmDetailsSuccessState(movieDetails: movieDetails));
        } else {
          emit(
            ShowFilmDetailsFailState(message: 'Something Wrong! Try again.'),
          );
        }
      } on Exception catch (_) {
        emit(ShowFilmDetailsFailState(message: 'Something Wrong! Try again.'));
      }
    });

    on<ShowDetailsOfTvShowEvent>((event, emit) async {
      emit(ShowFilmDetailsLoadingState());
      try {
        final tvShowDetails =
            await tmdbMovieRepository.getDetailsTvShow(event.tvShowId);
        if (tvShowDetails != null) {
          emit(ShowFilmDetailsSuccessState(movieDetails: tvShowDetails));
        } else {
          emit(
            ShowFilmDetailsFailState(message: 'Something Wrong! Try again.'),
          );
        }
      } on Exception catch (_) {
        emit(ShowFilmDetailsFailState(message: 'Something Wrong! Try again.'));
      }
    });
  }
}
