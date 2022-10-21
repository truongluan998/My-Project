import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationStartedEvent extends AuthenticationEvent {}

class SignInWithCredentialsPressedEvent extends AuthenticationEvent {
  final String email;
  final String password;

  SignInWithCredentialsPressedEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class SignUpWithCredentialsPressedEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String fullName;

  SignUpWithCredentialsPressedEvent({
    required this.email,
    required this.password,
    required this.fullName,
  });

  @override
  List<Object?> get props => [email, password, fullName];
}


