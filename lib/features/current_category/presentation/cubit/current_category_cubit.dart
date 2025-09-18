import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/category/category.dart';

class CurrentCategoryCubit extends Cubit<Category?> {
  CurrentCategoryCubit() : super(null);

  void selectCategory(Category category) => emit(category);
  void clearCategory() => emit(null);
}
