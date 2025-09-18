part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

final class CategoryLoad extends CategoryEvent {}

final class CategoryAdd extends CategoryEvent {
  const CategoryAdd({required this.name});

  final String name;

  @override
  List<Object> get props => super.props..addAll([name]);
}

final class CategoryEdit extends CategoryEvent {
  const CategoryEdit({required this.category});

  final Category category;

  @override
  List<Object> get props => super.props..addAll([category]);
}

final class CategoryDelete extends CategoryEvent {
  const CategoryDelete({required this.categoryId});

  final String categoryId;

  @override
  List<Object> get props => super.props..addAll([categoryId]);
}
