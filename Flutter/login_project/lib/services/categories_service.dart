import '../model/categories.dart';

abstract class CategoriesService {
  Future<CategoriesResponse?> getCategories ();
}