import 'package:equatable/equatable.dart';
import '../../../../../model/tmdb_movie/artists/artists_images_artists.dart';
abstract class ImagesOfArtistsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ImagesOfArtistsInitial extends ImagesOfArtistsState {}

class ShowImagesOfArtistsLoadingState extends ImagesOfArtistsState {}

class ShowImagesOfArtistsSuccessState extends ImagesOfArtistsState {
  final ImagesOfArtists? imagesOfArtists;

  ShowImagesOfArtistsSuccessState({required this.imagesOfArtists});

  @override
  List<Object?> get props => [imagesOfArtists];
}

class ShowImagesOfArtistsFailState extends ImagesOfArtistsState {
  final String message;

  ShowImagesOfArtistsFailState({required this.message});
}
