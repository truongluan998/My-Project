import 'package:equatable/equatable.dart';

abstract class TrailerOfMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTrailerOfMovieEvent extends TrailerOfMovieEvent {
  final int movieId;

  GetTrailerOfMovieEvent({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}

class GetTrailerOfTvShowEvent extends TrailerOfMovieEvent {
  final int tvShowId;

  GetTrailerOfTvShowEvent({required this.tvShowId});

  @override
  List<Object?> get props => [tvShowId];
}
