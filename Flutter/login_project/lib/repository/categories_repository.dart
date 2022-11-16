import '../models/categories.dart';

abstract class CategoriesRepository {
  Future<CategoriesResponse?> getCategories ();
}