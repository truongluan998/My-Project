import 'package:equatable/equatable.dart';
import '../../../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';

abstract class MostRecentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MostRecentInitial extends MostRecentState {}

class MostRecentListLoadingState extends MostRecentState {}

class MostRecentListSuccessState extends MostRecentState {
  final TMDBData? mostRecentList;

  MostRecentListSuccessState({required this.mostRecentList});

  @override
  List<Object?> get props => [mostRecentList];
}

class MostRecentListLoadMoreSuccessState extends MostRecentInitial{
  final List<Results>? mostRecentList;

  MostRecentListLoadMoreSuccessState({required this.mostRecentList});

  @override
  List<Object?> get props => [mostRecentList];
}

class MostRecentListFailState extends MostRecentState {
  final String message;

  MostRecentListFailState({required this.message});
}
