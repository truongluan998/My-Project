part of 'check_email_exits_bloc.dart';

@immutable
abstract class CheckEmailExitsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckEmailExitsInitial extends CheckEmailExitsState {}

class CheckEmailExitsLoading extends CheckEmailExitsState{}

class EmailAlreadyExists extends CheckEmailExitsState{
  final String email;

  EmailAlreadyExists({required this.email});

  @override
  List<Object?> get props => [email];
}

class EmailDoesNotExists extends CheckEmailExitsState{
  final String email;

  EmailDoesNotExists({required this.email});

  @override
  List<Object?> get props => [email];
}

class CheckEmailFail extends CheckEmailExitsState{
  final String message;

  CheckEmailFail({required this.message});

  @override
  List<Object?> get props => [message];
}
