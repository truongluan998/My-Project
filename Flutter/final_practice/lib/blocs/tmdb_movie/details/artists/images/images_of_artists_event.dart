import 'package:equatable/equatable.dart';
abstract class ImagesOfArtistsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetImagesOfArtistsEvent extends ImagesOfArtistsEvent {
  final int artistsId;

  GetImagesOfArtistsEvent({required this.artistsId});

  @override
  List<Object?> get props => [artistsId];
}
