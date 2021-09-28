import 'package:flutter_simple_dependency_injection/injector.dart';

import 'navigator/navigator_bloc.dart';

class BlocDependencies {
  static Injector initialise(Injector injector) {
    injector.map<MyNavigatorBloc>((injector) => MyNavigatorBloc());

    return injector;
  }
}