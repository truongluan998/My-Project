import 'package:equatable/equatable.dart';

abstract class CheckInternetConnectionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckInternetFirstTimeEvent extends CheckInternetConnectionEvent {}

class LostInternetEvent extends CheckInternetConnectionEvent {}

class ReconnectInternetEvent extends CheckInternetConnectionEvent {}
