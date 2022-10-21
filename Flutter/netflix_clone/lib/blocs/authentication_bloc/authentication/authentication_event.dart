part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationNewAccountSignInWithGoogle extends AuthenticationEvent {}

class AuthenticationNewAccountSignInWithFacebook extends AuthenticationEvent {}

class AuthenticationExited extends AuthenticationEvent {}
