import 'package:equatable/equatable.dart';
abstract class ReviewOfFilmEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetReviewsOfMovieEvent extends ReviewOfFilmEvent {
  final int movieId;

  GetReviewsOfMovieEvent({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}

class GetReviewsOfTvShowEvent extends ReviewOfFilmEvent {
  final int tvShowId;

  GetReviewsOfTvShowEvent({required this.tvShowId});

  @override
  List<Object?> get props => [tvShowId];
}
