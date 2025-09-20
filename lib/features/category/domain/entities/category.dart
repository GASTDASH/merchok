import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({required this.id, required this.name});

  const Category.empty() : id = '', name = '';

  final String id;
  final String name;

  static const String _emptyId = '';
  static const String _emptyName = '';

  @override
  List<Object?> get props => [id, name];

  bool get isEmpty => id == _emptyId && name == _emptyName;

  bool get isNotEmpty => !isEmpty;
}
