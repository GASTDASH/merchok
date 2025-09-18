import 'package:merchok/features/category/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<void> addCategory(Category category);
  Future<void> editCategory(Category category);
  Future<void> deleteCategory(String categoryId);
}
