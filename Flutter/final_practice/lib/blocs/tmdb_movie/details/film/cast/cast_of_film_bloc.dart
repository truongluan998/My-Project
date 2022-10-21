import 'package:bloc/bloc.dart';
import '../../../../../repository/api/tmdb_movie_repository.dart';

import 'cast_of_film_event.dart';
import 'cast_of_film_state.dart';

class CastOfFilmBloc extends Bloc<CastOfFilmEvent, CastOfFilmState> {
  final TMDBMovieRepository tmdbMovieRepository;

  CastOfFilmBloc(this.tmdbMovieRepository) : super(GetCastOfFilmInitial()) {
    on<GetCastOfMovieEvent>((event, emit) async {
      emit(GetCastOfFilmLoadingState());
      try {
        final castOfMovie =
            await tmdbMovieRepository.getCastOfMovie(event.movieId);
        if (castOfMovie != null) {
          emit(GetCastOfFilmSuccessState(castOfFilm: castOfMovie));
        } else {
          emit(
            GetCastOfFilmFailState(message: 'Something Wrong! Try again.'),
          );
        }
      } on Exception catch (_) {
        emit(GetCastOfFilmFailState(message: 'Something Wrong! Try again.'));
      }
    });

    on<GetCastOfTvShowEvent>((event, emit) async {
      emit(GetCastOfFilmLoadingState());
      try {
        final castOfTvShow   =
        await tmdbMovieRepository.getCastOfTvShow(event.tvShowId);
        if (castOfTvShow != null) {
          emit(GetCastOfFilmSuccessState(castOfFilm: castOfTvShow));
        } else {
          emit(
            GetCastOfFilmFailState(message: 'Something Wrong! Try again.'),
          );
        }
      } on Exception catch (_) {
        emit(GetCastOfFilmFailState(message: 'Something Wrong! Try again.'));
      }
    });
  }
}
