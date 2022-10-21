import 'package:equatable/equatable.dart';
import '../../../model/tmdb_movie/tv_show/tv_show.dart';

abstract class TrendingListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TrendingListInitialState extends TrendingListState {}

class TrendingListLoadingState extends TrendingListState{}

class TrendingListSuccessState extends TrendingListState{
  final TvShow? trendingList;

  TrendingListSuccessState({required this.trendingList});

  @override
  List<Object?> get props => [trendingList];
}

class TrendingListFailState extends TrendingListState{
  final String message;

  TrendingListFailState({required this.message});
}
