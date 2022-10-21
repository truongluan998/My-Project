part of 'check_email_exits_bloc.dart';

@immutable
abstract class CheckEmailExitsEvent extends Equatable {
  const CheckEmailExitsEvent();

  @override
  List<Object?> get props => [];
}

class PressToCheckEmail extends CheckEmailExitsEvent {
  final String email;

  const PressToCheckEmail({required this.email});

  @override
  List<Object?> get props => [email];
}
