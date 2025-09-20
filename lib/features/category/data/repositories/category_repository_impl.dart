import 'package:merchok/features/category/category.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final Map<String, Category> categories = {};

  @override
  Future<void> addCategory(Category category) async =>
      categories.addAll({category.id: category});

  @override
  Future<void> deleteCategory(String categoryId) async =>
      categories.remove(categoryId);

  @override
  Future<void> editCategory(Category category) async =>
      categories.addAll({category.id: category});

  @override
  Future<List<Category>> getCategories() async => categories.values.toList();
}
