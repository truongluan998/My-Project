import 'package:flutter_simple_dependency_injection/injector.dart';

import '../blocs/blocs_dependencies.dart';
import '../repository/repository_dependencies.dart';
import '../services/services_dependencies.dart';
import '../utility/utility_dependencies.dart';

class AppDependencies {
  static Injector injector = AppDependencies().initialise(Injector());

  Injector initialise(Injector injector) {
    UtilityDependencies.initialise(injector);
    ServicesDependencies.initialise(injector);
    RepositoryDependencies.initialise(injector);
    BlocsDependencies.initialise(injector);
    return injector;
  }
}
