import 'package:equatable/equatable.dart';
import '../../../../../model/tmdb_movie/general_movie_tv_show_and_artsits/trailer_film.dart';

abstract class TrailerOfFilmState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TrailerOfFilmInitial extends TrailerOfFilmState {}

class GetTrailerOfFilmLoadingState extends TrailerOfFilmState {}

class GetTrailerOfFilmSuccessState extends TrailerOfFilmState {
  final TrailerFilm? trailerOfFilm;

  GetTrailerOfFilmSuccessState({required this.trailerOfFilm});

  @override
  List<Object?> get props => [trailerOfFilm];
}

class GetTrailerOfFilmFailState extends TrailerOfFilmState {
  final String message;

  GetTrailerOfFilmFailState({required this.message});
}
