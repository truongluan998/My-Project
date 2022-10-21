import 'package:equatable/equatable.dart';

abstract class FilmDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShowDetailsOfMovieEvent extends FilmDetailsEvent {
  final int movieId;

  ShowDetailsOfMovieEvent({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}

class ShowDetailsOfTvShowEvent extends FilmDetailsEvent {
  final int tvShowId;

  ShowDetailsOfTvShowEvent({required this.tvShowId});

  @override
  List<Object?> get props => [tvShowId];
}
