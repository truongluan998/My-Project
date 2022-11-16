import 'package:get_it/get_it.dart';

import '../controllers/authentication_controller.dart';
import '../controllers/categories_controller.dart';

class ProviderDependencies {
  static GetIt initGetIt(GetIt getIt) {
    getIt
      ..registerFactory<AuthenticationController>(
        () => AuthenticationController(),
      )
      ..registerFactory<CategoriesController>(
        () => CategoriesController(),
      );
    return getIt;
  }
}
