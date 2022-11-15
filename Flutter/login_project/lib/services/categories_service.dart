import 'package:login_project/dependencies/app_dependencies.dart';
import 'package:login_project/model/categories.dart';

import '../../utils/rest_utils.dart';
import '../repository/categories_repository.dart';

class CategoriesService extends CategoriesRepository {
  final restUtils = AppDependencies.getIt.get<RestUtils>();

  @override
  Future<CategoriesResponse?> getCategories() async {
    try {
      final response = await restUtils.getDataFromAPI('cc_test');
      if (response != null) {
        return response.body;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
