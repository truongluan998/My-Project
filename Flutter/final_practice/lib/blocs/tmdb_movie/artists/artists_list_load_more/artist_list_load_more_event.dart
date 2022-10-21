import 'package:equatable/equatable.dart';

abstract class ArtistListLoadMoreEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetArtistListLoadMoreEvent extends ArtistListLoadMoreEvent {}

