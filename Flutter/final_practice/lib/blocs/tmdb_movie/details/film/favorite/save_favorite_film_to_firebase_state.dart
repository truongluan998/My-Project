import 'package:equatable/equatable.dart';

abstract class SaveFavoriteFilmToFirebaseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SaveFavoriteFilmToFirebaseInitial
    extends SaveFavoriteFilmToFirebaseState {}

class StoreFavoriteFilmSuccess extends SaveFavoriteFilmToFirebaseState {
  final String message;

  StoreFavoriteFilmSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class FavoriteFilmState extends SaveFavoriteFilmToFirebaseState {}

class NormalFilmState extends SaveFavoriteFilmToFirebaseState {}
