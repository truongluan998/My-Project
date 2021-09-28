part of 'navigator_bloc.dart';

@immutable
abstract class NavigatorEvent extends Equatable {}

class GoToLoginEvent extends NavigatorEvent {
  final BuildContext context;

  GoToLoginEvent({required this.context});

  @override
  List<Object?> get props => [];
}

class GoToRegisterEvent extends NavigatorEvent {
  final BuildContext context;

  GoToRegisterEvent({required this.context});

  @override
  List<Object?> get props => [];
}

class GoToChatEvent extends NavigatorEvent {
  final BuildContext context;

  GoToChatEvent({required this.context});

  @override
  List<Object?> get props => [];
}
