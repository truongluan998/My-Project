import 'package:flash_chat/bloc/bloc_dependencies.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:global_configuration/global_configuration.dart';

class AppDependencies {
  static Injector injector = AppDependencies().initialise(Injector());

  Injector initialise(Injector injector) {
    injector.map<GlobalConfiguration>(
      (injector) => GlobalConfiguration(),
      isSingleton: false,
    );

    BlocDependencies.initialise(injector);

    return injector;
  }
}
