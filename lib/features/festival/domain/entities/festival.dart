// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
    };
  }

  factory Festival.fromMap(Map<String, dynamic> map) {
    return Festival(
      id: map['id'] as String,
      name: map['name'] as String,
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Festival.fromJson(String source) =>
      Festival.fromMap(json.decode(source) as Map<String, dynamic>);
}
