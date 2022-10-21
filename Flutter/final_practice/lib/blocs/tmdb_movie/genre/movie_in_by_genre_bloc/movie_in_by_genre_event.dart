import 'package:equatable/equatable.dart';

abstract class MovieInByGenreEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMovieInByGenreEvent extends MovieInByGenreEvent {
  final int genreId;

  GetMovieInByGenreEvent({required this.genreId});

  @override
  List<Object?> get props => [genreId];
}
