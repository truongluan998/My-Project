import 'package:bloc/bloc.dart';
import '../../../../../repository/api/tmdb_movie_repository.dart';

import 'review_of_film_event.dart';
import 'reviews_of_film_state.dart';

class ReviewOfFilmBloc extends Bloc<ReviewOfFilmEvent, ReviewsOfFilmState> {
  final TMDBMovieRepository tmdbMovieRepository;

  ReviewOfFilmBloc(this.tmdbMovieRepository) : super(ReviewsOfFilmInitial()) {
    on<GetReviewsOfMovieEvent>((event, emit) async {
      emit(GetReviewsOfFilmLoadingState());
      try {
        final reviewsOfMovie =
            await tmdbMovieRepository.getReviewsOfMovie(event.movieId);
        if (reviewsOfMovie != null) {
          emit(GetReviewsOfFilmSuccessState(reviewsOfFilm: reviewsOfMovie));
        } else {
          emit(
            GetReviewsOfFilmFailState(message: 'Something Wrong! Try again.'),
          );
        }
      } on Exception catch (_) {
        emit(
          GetReviewsOfFilmFailState(message: 'Something Wrong! Try again.'),
        );
      }
    });

    on<GetReviewsOfTvShowEvent>((event, emit) async {
      emit(GetReviewsOfFilmLoadingState());
      try {
        final reviewsOfTvShow =
        await tmdbMovieRepository.getReviewsOfTvShow(event.tvShowId);
        if (reviewsOfTvShow != null) {
          emit(GetReviewsOfFilmSuccessState(reviewsOfFilm: reviewsOfTvShow));
        } else {
          emit(
            GetReviewsOfFilmFailState(message: 'Something Wrong! Try again.'),
          );
        }
      } on Exception catch (_) {
        emit(
          GetReviewsOfFilmFailState(message: 'Something Wrong! Try again.'),
        );
      }
    });
  }
}
