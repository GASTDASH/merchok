part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  const CategoryLoaded({required this.categoryList});

  final List<Category> categoryList;

  @override
  List<Object?> get props => super.props..addAll([categoryList]);
}

final class CategoryLoading extends CategoryState {
  const CategoryLoading({this.message});

  final String? message;

  @override
  List<Object?> get props => super.props..addAll([message]);
}

final class CategoryError extends CategoryState {
  const CategoryError({this.error});

  final Object? error;

  @override
  List<Object?> get props => super.props..addAll([error]);
}
