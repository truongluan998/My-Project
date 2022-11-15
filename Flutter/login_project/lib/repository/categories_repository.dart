import '../model/categories.dart';

abstract class CategoriesRepository {
  Future<CategoriesResponse?> getCategories ();
}