import 'package:equatable/equatable.dart';
import '../../../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';

abstract class UpcomingListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpcomingListInitial extends UpcomingListState {}

class UpcomingListLoadingState extends UpcomingListState{}

class UpcomingListSuccessState extends UpcomingListState{
  final TMDBData? upcomingList;

  UpcomingListSuccessState({required this.upcomingList});

  @override
  List<Object?> get props => [upcomingList];
}

class UpcomingListLoadMoreSuccessState extends UpcomingListState{
  final List<Results>? upcomingList;

  UpcomingListLoadMoreSuccessState({required this.upcomingList});

  @override
  List<Object?> get props => [upcomingList];
}

class UpcomingListFailState extends UpcomingListState{
  final String message;

  UpcomingListFailState({required this.message});
}
