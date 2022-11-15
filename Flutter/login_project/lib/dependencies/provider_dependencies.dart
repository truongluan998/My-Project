import 'package:get_it/get_it.dart';

import '../controller/authentication_controller.dart';
import '../controller/categories_controller.dart';


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
