part of 'navigator_bloc.dart';

@immutable
abstract class NavigatorState extends Equatable {}

class NavigatorInitial extends NavigatorState {
  @override
  List<Object?> get props => [];
}

class LoadedLoginScreen extends NavigatorState {
  final loginScreen;

  LoadedLoginScreen({required this.loginScreen});

  @override
  List<Object?> get props => [];
}

class LoadedRegisterScreen extends NavigatorState {
  final registerScreen;

  LoadedRegisterScreen({required this.registerScreen});

  @override
  List<Object?> get props => [];
}
