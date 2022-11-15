import 'package:login_project/services/categories_service.dart';
import 'package:login_project/services/authentication_service.dart';
import 'package:get_it/get_it.dart';
import 'package:login_project/services/db_service.dart';

import '../business/authentication_business.dart';
import '../business/categories_business.dart';
import '../business/db_helper.dart';

class ServiceDependencies {
  static GetIt initGetIt(GetIt getIt) {
    getIt
      ..registerFactory<AuthenticationService>(
        () => AuthenticationBusiness(),
      )
      ..registerFactory<DbService>(
        () => DBHelper(),
      )
      ..registerFactory<CategoriesService>(
        () => CategoriesBusiness(),
      );
    return getIt;
  }
}
