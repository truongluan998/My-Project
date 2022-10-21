import 'package:equatable/equatable.dart';

abstract class CheckInternetConnectionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckInternetConnectionInitial extends CheckInternetConnectionState {
  final String? message;

  CheckInternetConnectionInitial({this.message});
  @override
  List<Object?> get props => [message];
}

class LostInternetState extends CheckInternetConnectionState{
  final String message;

  LostInternetState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ReconnectTheInternetState extends CheckInternetConnectionState{
  final String message;

  ReconnectTheInternetState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ReconnectTheInternetFailState extends CheckInternetConnectionState{
  final String message;

  ReconnectTheInternetFailState({required this.message});

  @override
  List<Object?> get props => [message];
}
