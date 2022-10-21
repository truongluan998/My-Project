import 'package:equatable/equatable.dart';
import '../../../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';


abstract class PopularListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PopularListInitial extends PopularListState {}

class PopularListLoadingState extends PopularListState{}

class PopularListSuccessState extends PopularListState{
  final TMDBData? popularList;

  PopularListSuccessState({required this.popularList});

  @override
  List<Object?> get props => [popularList];
}

class PopularListLoadMoreSuccessState extends PopularListState{
  final List<Results>? popularList;

  PopularListLoadMoreSuccessState({required this.popularList});

  @override
  List<Object?> get props => [popularList];
}

class PopularListFailState extends PopularListState{
  final String message;

  PopularListFailState({required this.message});
}
