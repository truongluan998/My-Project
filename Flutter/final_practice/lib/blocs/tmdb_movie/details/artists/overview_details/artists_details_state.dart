import 'package:equatable/equatable.dart';
import '../../../../../model/tmdb_movie/artists/artists_details.dart';
abstract class ArtistsDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ArtistsDetailsInitial extends ArtistsDetailsState {}

class ShowArtistsDetailsLoadingState extends ArtistsDetailsState {}

class ShowArtistsDetailsSuccessState extends ArtistsDetailsState {
  final ArtistsDetails? artistsDetails;

  ShowArtistsDetailsSuccessState({required this.artistsDetails});

  @override
  List<Object?> get props => [artistsDetails];
}

class ShowArtistsDetailsFailState extends ArtistsDetailsState {
  final String message;

  ShowArtistsDetailsFailState({required this.message});
}
