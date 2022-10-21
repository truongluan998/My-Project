import 'package:equatable/equatable.dart';

abstract class SearchMultiEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDataFromSearchEvent extends SearchMultiEvent {
  final String query;

  GetDataFromSearchEvent({required this.query});

  @override
  List<Object?> get props => [];
}

class CloseSearchInAppBarEvent extends SearchMultiEvent {}
