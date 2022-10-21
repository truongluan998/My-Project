part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  AuthenticationFailure({required this.exception, required this.message});

  final String message;
  final ListExceptionAuthentication exception;

  @override
  List<Object?> get props => [message];
}

class AuthenticationSuccess extends AuthenticationState {
  AuthenticationSuccess({required this.authenticationDetail});

  final AuthenticationDetail authenticationDetail;

  @override
  List<Object?> get props => [authenticationDetail];
}
