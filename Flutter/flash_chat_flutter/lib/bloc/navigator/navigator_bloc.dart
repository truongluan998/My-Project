import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'navigator_event.dart';
part 'navigator_state.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, NavigatorState> {
  NavigatorBloc() : super(NavigatorInitial());

  @override
  Stream<NavigatorState> mapEventToState(
    NavigatorEvent event,
  ) async* {
    if (event is GoToLoginEvent) {
      yield LoadedLoginScreen(
        loginScreen: event.context.router.pushNamed('/login'),
      );
    }
    if (event is GoToRegisterEvent) {
      yield LoadedRegisterScreen(
        registerScreen: event.context.router.pushNamed('/registration'),
      );
    }
  }
}
