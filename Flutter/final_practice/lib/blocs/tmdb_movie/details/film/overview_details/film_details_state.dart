import 'package:equatable/equatable.dart';
import '../../../../../model/tmdb_movie/general_movie_tv_show_and_artsits/film_details.dart';

abstract class FilmDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShowFilmDetailsInitial extends FilmDetailsState {}

class ShowFilmDetailsLoadingState extends FilmDetailsState {}

class ShowFilmDetailsSuccessState extends FilmDetailsState {
  final FilmDetails? movieDetails;

  ShowFilmDetailsSuccessState({required this.movieDetails});

  @override
  List<Object?> get props => [movieDetails];
}

class ShowFilmDetailsFailState extends FilmDetailsState {
  final String message;

  ShowFilmDetailsFailState({required this.message});
}
