import 'package:equatable/equatable.dart';
abstract class ArtistsDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShowDetailsOfArtistsEvent extends ArtistsDetailsEvent {
  final int artistsId;

  ShowDetailsOfArtistsEvent({required this.artistsId});

  @override
  List<Object?> get props => [artistsId];
}
