import 'package:equatable/equatable.dart';
import '../../../../../model/tmdb_movie/general_movie_tv_show_and_artsits/reviews_of_film.dart';
abstract class ReviewsOfFilmState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReviewsOfFilmInitial extends ReviewsOfFilmState {}

class GetReviewsOfFilmLoadingState extends ReviewsOfFilmState {}

class GetReviewsOfFilmSuccessState extends ReviewsOfFilmState {
  final ReviewsOfFilm? reviewsOfFilm;

  GetReviewsOfFilmSuccessState({required this.reviewsOfFilm});

  @override
  List<Object?> get props => [reviewsOfFilm];
}

class GetReviewsOfFilmFailState extends ReviewsOfFilmState {
  final String message;

  GetReviewsOfFilmFailState({required this.message});
}

