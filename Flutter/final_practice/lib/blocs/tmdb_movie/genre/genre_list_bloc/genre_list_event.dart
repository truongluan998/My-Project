import 'package:equatable/equatable.dart';

abstract class GenreListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetGenreListEvent extends GenreListEvent {}

