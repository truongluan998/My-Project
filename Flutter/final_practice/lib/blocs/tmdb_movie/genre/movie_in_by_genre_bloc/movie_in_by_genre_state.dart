import 'package:equatable/equatable.dart';
import '../../../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
abstract class MovieInByGenreState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieInByGenreInitial extends MovieInByGenreState {}

class MovieInByGenreLoadingState extends MovieInByGenreState{}

class MovieInByGenreSuccessState extends MovieInByGenreState{
  final List<Results>? movieInByGenreList;

  MovieInByGenreSuccessState({required this.movieInByGenreList});

  @override
  List<Object?> get props => [movieInByGenreList];
}

class MovieInByGenreFailState extends MovieInByGenreState{
  final String message;

  MovieInByGenreFailState({required this.message});
}
