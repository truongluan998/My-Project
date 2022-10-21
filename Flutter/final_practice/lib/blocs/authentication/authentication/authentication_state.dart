import 'package:equatable/equatable.dart';
import '../../../model/authentication/authentication_details.dart';
import '../../../utility/exception.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationSuccessState extends AuthenticationState {
  AuthenticationSuccessState({this.authenticationDetail});

  final AuthenticationDetail? authenticationDetail;

  @override
  List<Object?> get props => [authenticationDetail];
}

class AuthenticationFailureState extends AuthenticationState {
  AuthenticationFailureState({required this.exception, required this.message});

  final String message;
  final ListExceptionAuthentication exception;

  @override
  List<Object?> get props => [message];
}




