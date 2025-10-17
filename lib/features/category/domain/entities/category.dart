import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 5)
class Category extends Equatable {
  const Category({required this.id, required this.name});

  const Category.empty() : id = '', name = '';

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  static const String _emptyId = '';
  static const String _emptyName = '';

  @override
  List<Object?> get props => [id, name];

  bool get isEmpty => id == _emptyId && name == _emptyName;

  bool get isNotEmpty => !isEmpty;
}
