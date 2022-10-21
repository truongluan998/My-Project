import 'package:equatable/equatable.dart';

abstract class PopularListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetPopularListEvent extends PopularListEvent {}

class GetPopularListLoadMoreEvent extends PopularListEvent {}


