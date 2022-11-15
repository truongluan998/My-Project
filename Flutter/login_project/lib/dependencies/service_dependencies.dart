import 'package:login_project/repository/categories_repository.dart';
import 'package:login_project/repository/db_repository.dart';
import 'package:login_project/services/categories_service.dart';
import 'package:login_project/services/authentication_service.dart';
import 'package:get_it/get_it.dart';

import '../repository/authentication_repository.dart';
import '../services/db_helper.dart';

class ServiceDependencies {
  static GetIt initGetIt(GetIt getIt) {
    getIt
      ..registerFactory<AuthenticationRepository>(
        () => AuthenticationService(),
      )
      ..registerFactory<DBRepository>(
        () => DBHelper(),
      )
      ..registerFactory<CategoriesRepository>(
        () => CategoriesService(),
      );
    return getIt;
  }
}
