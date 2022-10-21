import 'package:equatable/equatable.dart';
import '../../../../../model/tmdb_movie/general_movie_tv_show_and_artsits/film_details.dart';
import '../../../../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';

abstract class StoreFavoriteFilmToFirebaseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SaveToFavoriteListEvent extends StoreFavoriteFilmToFirebaseEvent {
  final FilmDetails results;
  final MediaType mediaType;

  SaveToFavoriteListEvent({required this.results, required this.mediaType});

  @override
  List<Object?> get props => [results, mediaType];
}

class RemoveFromFavoriteListEvent extends StoreFavoriteFilmToFirebaseEvent {
  final int filmId;

  RemoveFromFavoriteListEvent({required this.filmId});

  @override
  List<Object?> get props => [filmId];
}

class CheckFavoriteFilmEvent extends StoreFavoriteFilmToFirebaseEvent{
  final int filmId;

  CheckFavoriteFilmEvent({required this.filmId});

  @override
  List<Object?> get props => [filmId];
}
