import 'package:get_it/get_it.dart';
import 'package:login_project/repositories/categories_repository.dart';
import '../repositories/authentication_repository.dart';
import '../repositories/db_repository.dart';

class RepositoriesDependencies {
  static GetIt initGetIt(GetIt getIt) {
    getIt
      ..registerFactory<AuthenticationRepository>(
          () => AuthenticationRepository())
      ..registerFactory<DBRepository>(() => DBRepository())
      ..registerFactory<CategoriesRepository>(() => CategoriesRepository());
    return getIt;
  }
}
