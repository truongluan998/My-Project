import 'package:equatable/equatable.dart';
import '../../../../model/tmdb_movie/movie/genre.dart';

abstract class GenreListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GenreListInitial extends GenreListState {}

class GenreListLoadingState extends GenreListState{}

class GenreListSuccessState extends GenreListState{
  final Genre? genreList;

  GenreListSuccessState({required this.genreList});

  @override
  List<Object?> get props => [genreList];
}

class GenreListFailState extends GenreListState{
  final String message;

  GenreListFailState({required this.message});
}
