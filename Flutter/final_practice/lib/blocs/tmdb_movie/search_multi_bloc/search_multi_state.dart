import 'package:equatable/equatable.dart';
import '../../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';

abstract class SearchMultiState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchMultiInitial extends SearchMultiState {}

class SearchMultiLoadingState extends SearchMultiState {}

class SearchMultiSuccessState extends SearchMultiState {
  final TMDBData? result;

  SearchMultiSuccessState({required this.result});

  @override
  List<Object?> get props => [result];
}

class SearchMultiLFailState extends SearchMultiState{
  final String message;

  SearchMultiLFailState({required this.message});

  @override
  List<Object?> get props => [message];
}

class CloseSearchInAppBarState extends SearchMultiState{}
