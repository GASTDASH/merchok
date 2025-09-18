import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/category/category.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:uuid/uuid.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryBloc({required CategoryRepository categoryRepository})
    : _categoryRepository = categoryRepository,
      super(CategoryInitial()) {
    on<CategoryLoad>((event, emit) async {
      try {
        emit(CategoryLoading(message: S.current.categoryLoading));
        final categoryList = await _categoryRepository.getCategories();
        emit(CategoryLoaded(categoryList: categoryList));
      } catch (e) {
        emit(CategoryError(error: e));
      }
    });
    on<CategoryAdd>((event, emit) async {
      try {
        emit(CategoryLoading(message: S.current.categoryCreating));
        await _categoryRepository.addCategory(
          Category(id: Uuid().v4(), name: event.name),
        );
        add(CategoryLoad());
      } catch (e) {
        emit(CategoryError(error: e));
      }
    });
    on<CategoryDelete>((event, emit) async {
      try {
        emit(CategoryLoading(message: S.current.categoryDeleting));
        await _categoryRepository.deleteCategory(event.categoryId);
        add(CategoryLoad());
      } catch (e) {
        emit(CategoryError(error: e));
      }
    });
  }
}
