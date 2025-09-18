import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'festival.g.dart';

@HiveType(typeId: 1)
class Festival extends Equatable {
  const Festival({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final DateTime startDate;

  @HiveField(3)
  final DateTime endDate;

  Festival copyWith({
    String? id,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
  }) => Festival(
    id: id ?? this.id,
    name: name ?? this.name,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
  );

  @override
  List<Object?> get props => [id, name, startDate, endDate];
}
