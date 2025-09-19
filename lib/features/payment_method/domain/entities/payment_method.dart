// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'payment_method.g.dart';

@HiveType(typeId: 2)
class PaymentMethod extends Equatable {
  const PaymentMethod({
    required this.id,
    required this.name,
    required this.information,
    this.description,
    this.iconPath,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String information;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final String? iconPath;

  @override
  List<Object?> get props {
    return [id, name, information, description, iconPath];
  }

  PaymentMethod copyWith({
    String? id,
    String? name,
    String? information,
    String? description,
    String? iconPath,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      name: name ?? this.name,
      information: information ?? this.information,
      description: description ?? this.description,
      iconPath: iconPath ?? this.iconPath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'information': information,
      'description': description,
      'iconPath': iconPath,
    };
  }

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      id: map['id'] as String,
      name: map['name'] as String,
      information: map['information'] as String,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      iconPath: map['iconPath'] != null ? map['iconPath'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethod.fromJson(String source) =>
      PaymentMethod.fromMap(json.decode(source) as Map<String, dynamic>);
}
