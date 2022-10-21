import 'package:equatable/equatable.dart';

abstract class MostRecentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMostRecentListEvent extends MostRecentEvent {}

class GetMostRecentListLoadMoreEvent extends MostRecentEvent {}

