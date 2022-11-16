import 'package:login_project/dependencies/app_dependencies.dart';
import 'package:login_project/models/categories.dart';

import '../../utils/rest_utils.dart';
import '../repository/categories_repository.dart';

class CategoriesService extends CategoriesRepository {
  final restUtils = AppDependencies.getIt.get<RestUtils>();

  @override
  Future<CategoriesResponse?> getCategories() async {
    final response = await restUtils.getDataFromAPI('cc_test');
    if (response != null) {
      return response.body;
    } else {
      return null;
    }
  }
}
