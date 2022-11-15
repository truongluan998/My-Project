import 'package:login_project/dependencies/app_dependencies.dart';
import 'package:login_project/model/categories.dart';
import 'package:login_project/services/categories_service.dart';

import '../../utils/rest_utils.dart';

class CategoriesBusiness extends CategoriesService {
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
