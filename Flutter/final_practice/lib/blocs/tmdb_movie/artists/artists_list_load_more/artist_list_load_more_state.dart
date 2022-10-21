import 'package:equatable/equatable.dart';
import '../../../../model/tmdb_movie/artists/person.dart';

abstract class ArtistListLoadMoreState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ArtistListLoadMoreInitial extends ArtistListLoadMoreState {}

class ArtistListLoadMoreLoadingState extends ArtistListLoadMoreState{}

class ArtistListLoadMoreSuccessState extends ArtistListLoadMoreState{
  final List<Results>? artistsList;

  ArtistListLoadMoreSuccessState({required this.artistsList});

  @override
  List<Object?> get props => [artistsList];
}

class ArtistListLoadMoreFailState extends ArtistListLoadMoreState{
  final String message;

  ArtistListLoadMoreFailState({required this.message});
}

