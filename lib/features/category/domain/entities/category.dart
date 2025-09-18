import 'package:equatable/equatable.dart';

class Category extends Equatable {
  static const String _emptyId = '';
  static const String _emptyName = '';

  const Category({required this.id, required this.name});

  const Category.empty() : id = '', name = '';

  final String id;
  final String name;

  bool get isEmpty => id == _emptyId && name == _emptyName;
  bool get isNotEmpty => !isEmpty;

  @override
  List<Object?> get props => [id, name];
}
