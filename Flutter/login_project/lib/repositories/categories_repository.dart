import 'package:login_project/model/categories.dart';
import 'package:login_project/services/categories_service.dart';

import '../dependencies/app_dependencies.dart';

class CategoriesRepository {
  final _categoriesService = AppDependencies.getIt.get<CategoriesService>();

  Future<CategoriesResponse?> getCategories() async =>
      await _categoriesService.getCategories();
}
