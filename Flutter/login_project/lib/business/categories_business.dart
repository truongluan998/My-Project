import 'package:login_project/models/categories.dart';

import '../dependencies/app_dependencies.dart';
import '../repository/categories_repository.dart';

class CategoriesBusiness {
  final _categoriesService = AppDependencies.getIt.get<CategoriesRepository>();

  Future<CategoriesResponse?> getCategories() async =>
      await _categoriesService.getCategories();
}
