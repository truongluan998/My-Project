import 'package:equatable/equatable.dart';

abstract class UpcomingListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUpcomingListEvent extends UpcomingListEvent {}

class GetUpcomingListLoadMoreEvent extends UpcomingListEvent {}

