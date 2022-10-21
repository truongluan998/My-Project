import 'package:equatable/equatable.dart';
import '../../../../../model/tmdb_movie/artists/person.dart';

abstract class CastOfFilmState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCastOfFilmInitial extends CastOfFilmState {}

class GetCastOfFilmLoadingState extends CastOfFilmState {}

class GetCastOfFilmSuccessState extends CastOfFilmState {
  final Person? castOfFilm;

  GetCastOfFilmSuccessState({required this.castOfFilm});

  @override
  List<Object?> get props => [castOfFilm];
}

class GetCastOfFilmFailState extends CastOfFilmState {
  final String message;

  GetCastOfFilmFailState({required this.message});
}
