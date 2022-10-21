import 'package:equatable/equatable.dart';
abstract class CastOfFilmEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCastOfMovieEvent extends CastOfFilmEvent {
  final int movieId;

  GetCastOfMovieEvent({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}

class GetCastOfTvShowEvent extends CastOfFilmEvent {
  final int tvShowId;

  GetCastOfTvShowEvent({required this.tvShowId});

  @override
  List<Object?> get props => [tvShowId];
}
