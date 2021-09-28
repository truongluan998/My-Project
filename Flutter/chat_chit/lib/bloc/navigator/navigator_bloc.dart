import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';

part 'navigator_event.dart';

part 'navigator_state.dart';

class MyNavigatorBloc extends Bloc<MyNavigatorEvent, MyNavigatorState> {
  MyNavigatorBloc() : super(NavigatorInitial());

  @override
  Stream<MyNavigatorState> mapEventToState(
    MyNavigatorEvent event,
  ) async* {
    if (event is GoToLoginEvent) {
      LoadedLoginScreen(
        loginScreen: event.context.router.pushNamed('/login'),
      );
    }
    if (event is GoToRegisterEvent) {
      LoadedRegisterScreen(
        registerScreen: event.context.router.pushNamed('/registration'),
      );
    }
  }
}
