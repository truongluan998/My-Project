import 'package:flash_chat/bloc/navigator/navigator_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class BlocDependencies {
  static Injector initialise(Injector injector) {
    injector.map<NavigatorBloc>((injector) => NavigatorBloc());

    return injector;
  }
}