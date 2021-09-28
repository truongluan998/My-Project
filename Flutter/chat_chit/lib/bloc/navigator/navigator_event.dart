part of 'navigator_bloc.dart';

@immutable
abstract class MyNavigatorEvent extends Equatable {}

class GoToLoginEvent extends MyNavigatorEvent {
  final BuildContext context;

  GoToLoginEvent({required this.context});

  @override
  List<Object?> get props => [];
}

class GoToRegisterEvent extends MyNavigatorEvent {
  final BuildContext context;

  GoToRegisterEvent({required this.context});

  @override
  List<Object?> get props => [];
}

class GoToChatEvent extends MyNavigatorEvent {
  final BuildContext context;

  GoToChatEvent({required this.context});

  @override
  List<Object?> get props => [];
}
