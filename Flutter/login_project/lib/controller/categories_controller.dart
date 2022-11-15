import 'package:flutter/cupertino.dart';
import 'package:login_project/model/categories.dart';

import '../dependencies/app_dependencies.dart';
import '../repositories/categories_repository.dart';

class CategoriesController extends ChangeNotifier{
  final _authenticationRepository =
  AppDependencies.getIt.get<CategoriesRepository>();

  var categoriesResponse = CategoriesResponse();
  bool isLoading = false;
  bool getCategoriesFalse = false;

  Future<void> getCategories () async {
    isLoading = true;
    notifyListeners();
    final response = await _authenticationRepository.getCategories();
    if (response != null) {
      categoriesResponse = response;
      isLoading = false;
      getCategoriesFalse = false;
      notifyListeners();
    } else {
      isLoading = false;
      getCategoriesFalse = true;
      notifyListeners();
    }
  }
}