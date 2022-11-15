import 'package:get_it/get_it.dart';

import '../business/authentication_business.dart';
import '../business/categories_business.dart';
import '../business/db_business.dart';

class BusinessDependencies {
  static GetIt initGetIt(GetIt getIt) {
    getIt
      ..registerFactory<AuthenticationBusiness>(() => AuthenticationBusiness())
      ..registerFactory<DBBusiness>(() => DBBusiness())
      ..registerFactory<CategoriesBusiness>(() => CategoriesBusiness());
    return getIt;
  }
}
