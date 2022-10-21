import 'package:bloc/bloc.dart';

import '../../../../../repository/api/tmdb_movie_repository.dart';
import 'trailer_of_film_event.dart';
import 'trailer_of_film_state.dart';

class TrailerOfFilmBloc extends Bloc<TrailerOfMovieEvent, TrailerOfFilmState> {
  final TMDBMovieRepository tmdbMovieRepository;

  TrailerOfFilmBloc(this.tmdbMovieRepository) : super(TrailerOfFilmInitial()) {
    on<GetTrailerOfMovieEvent>((event, emit) async {
      emit(GetTrailerOfFilmLoadingState());
      try {
        final trailerOfMovie =
            await tmdbMovieRepository.getTrailerOfMovie(event.movieId);
        if (trailerOfMovie != null) {
          emit(GetTrailerOfFilmSuccessState(trailerOfFilm: trailerOfMovie));
        } else {
          emit(
            GetTrailerOfFilmFailState(message: 'Something Wrong! Try again.'),
          );
        }
      } on Exception catch (_) {
        emit(
          GetTrailerOfFilmFailState(message: 'Something Wrong! Try again.'),
        );
      }
    });

    on<GetTrailerOfTvShowEvent>((event, emit) async {
      emit(GetTrailerOfFilmLoadingState());
      try {
        final trailerOfTvShow =
            await tmdbMovieRepository.getTrailerOfTvShow(event.tvShowId);
        if (trailerOfTvShow != null) {
          emit(GetTrailerOfFilmSuccessState(trailerOfFilm: trailerOfTvShow));
        } else {
          emit(
            GetTrailerOfFilmFailState(message: 'Something Wrong! Try again.'),
          );
        }
      } on Exception catch (_) {
        emit(
          GetTrailerOfFilmFailState(message: 'Something Wrong! Try again.'),
        );
      }
    });
  }
}
