import 'package:flutter/cupertino.dart';
import 'package:login_project/business/categories_business.dart';
import 'package:login_project/models/categories.dart';

import '../dependencies/app_dependencies.dart';

class CategoriesController extends ChangeNotifier {
  final _categoriesBusiness = AppDependencies.getIt.get<CategoriesBusiness>();

  var categoriesResponse = CategoriesResponse();
  bool isLoading = false;
  bool getCategoriesStatus = false;

  Future<void> getCategories() async {
    isLoading = true;
    notifyListeners();
    final response = await _categoriesBusiness.getCategories();
    if (response != null) {
      categoriesResponse = response;
      isLoading = false;
      getCategoriesStatus = true;
      notifyListeners();
    } else {
      isLoading = false;
      getCategoriesStatus = false;
      notifyListeners();
    }
  }
}
