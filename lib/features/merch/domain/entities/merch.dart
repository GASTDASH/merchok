// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'merch.g.dart';

@HiveType(typeId: 0)
class Merch extends Equatable {
  const Merch({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.purchasePrice,
    this.image,
    this.categoryId,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final double? purchasePrice;

  @HiveField(5)
  final Uint8List? image;

  @HiveField(6)
  final String? categoryId;

  Merch copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? purchasePrice,
    Uint8List? image,
    String? categoryId,
  }) => Merch(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    price: price ?? this.price,
    purchasePrice: purchasePrice ?? this.purchasePrice,
    image: image ?? this.image,
    categoryId: categoryId ?? this.categoryId,
  );

  Merch clearCategoryId() => Merch(
    id: id,
    name: name,
    description: description,
    price: price,
    purchasePrice: purchasePrice,
    image: image,
    categoryId: null,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    purchasePrice,
    image,
    categoryId,
  ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'purchasePrice': purchasePrice,
      'image': image,
      'categoryId': categoryId,
    };
  }

  factory Merch.fromMap(Map<String, dynamic> map) {
    return Merch(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      price: map['price'] as double,
      purchasePrice: map['purchasePrice'] != null
          ? map['purchasePrice'] as double
          : null,
      image: map['image'] != null ? map['image'] as Uint8List : null,
      categoryId: map['categoryId'] != null
          ? map['categoryId'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Merch.fromJson(String source) =>
      Merch.fromMap(json.decode(source) as Map<String, dynamic>);
}
