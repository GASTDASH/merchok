import 'package:hive/hive.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/category/category.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final Box<Category> categoryBox = Hive.box(HiveBoxesNames.categories);

  @override
  Future<void> addCategory(Category category) async =>
      categoryBox.put(category.id, category);

  @override
  Future<void> deleteCategory(String categoryId) async =>
      categoryBox.delete(categoryId);

  @override
  Future<void> editCategory(Category category) async =>
      categoryBox.put(category.id, category);

  @override
  Future<List<Category>> getCategories() async => categoryBox.values.toList();
}
