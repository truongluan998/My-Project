import 'package:equatable/equatable.dart';

abstract class TrendingListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTrendingListEvent extends TrendingListEvent {}
