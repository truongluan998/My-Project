part of 'navigator_bloc.dart';

@immutable
abstract class MyNavigatorState extends Equatable {}

class NavigatorInitial extends MyNavigatorState {
  @override
  List<Object?> get props => [];
}

class LoadedLoginScreen extends MyNavigatorState {
  final Future<dynamic> loginScreen;

  LoadedLoginScreen({required this.loginScreen});

  @override
  List<Object?> get props => [loginScreen];
}

class LoadedRegisterScreen extends MyNavigatorState {
  final Future<dynamic> registerScreen;

  LoadedRegisterScreen({required this.registerScreen});

  @override
  List<Object?> get props => [registerScreen];
}
