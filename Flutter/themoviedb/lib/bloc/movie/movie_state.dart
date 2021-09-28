
import 'package:themoviedb/model/movie_tmdb.dart';

abstract class MoviesState {}

class MoviesInitState extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<Result> movieTMDB;
  MoviesLoaded({required this.movieTMDB});
  List<Object> get props => [this.movieTMDB];
}

class MoviesError extends MoviesState {
  final error;
  MoviesError({this.error});
  List<Object> get props => [this.error];
}


