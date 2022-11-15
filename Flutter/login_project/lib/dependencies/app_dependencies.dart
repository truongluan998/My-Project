import 'package:get_it/get_it.dart';
import 'package:login_project/dependencies/provider_dependencies.dart';
import 'package:login_project/dependencies/rest_utils_dependencies.dart';

import 'repositories_dependencies.dart';
import 'service_dependencies.dart';

class AppDependencies {
  static GetIt getIt = GetIt.instance;

  static GetIt configureDependencies() {
    RestUtilsDependencies.initGetIt(getIt);
    ServiceDependencies.initGetIt(getIt);
    RepositoriesDependencies.initGetIt(getIt);
    ProviderDependencies.initGetIt(getIt);
    return getIt;
  }
}