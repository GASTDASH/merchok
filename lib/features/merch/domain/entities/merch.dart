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
    this.thumbnail,
    this.categoryId,
  });

  factory Merch.fromJson(String source) =>
      Merch.fromMap(json.decode(source) as Map<String, dynamic>);

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
      image: map['image'] != null
          ? Uint8List.fromList((map['image'] as List).cast<int>())
          : null,
      thumbnail: map['thumbnail'] != null
          ? Uint8List.fromList((map['thumbnail'] as List).cast<int>())
          : null,
      categoryId: map['categoryId'] != null
          ? map['categoryId'] as String
          : null,
    );
  }

  @HiveField(6)
  final String? categoryId;

  @HiveField(2)
  final String? description;

  @HiveField(0)
  final String id;

  @HiveField(5)
  final Uint8List? image;

  @HiveField(1)
  final String name;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final double? purchasePrice;

  @HiveField(7)
  final Uint8List? thumbnail;

  static const _omit = Object();

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

  Merch copyWith({
    String? id,
    String? name,
    Object? description = _omit,
    double? price,
    Object? purchasePrice = _omit,
    Object? image = _omit,
    Object? thumbnail = _omit,
    Object? categoryId = _omit,
  }) => Merch(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description == _omit
        ? this.description
        : description as String?,
    price: price ?? this.price,
    purchasePrice: purchasePrice == _omit
        ? this.purchasePrice
        : purchasePrice as double?,
    image: image == _omit ? this.image : image as Uint8List?,
    thumbnail: thumbnail == _omit ? this.thumbnail : thumbnail as Uint8List?,
    categoryId: categoryId == _omit ? this.categoryId : categoryId as String?,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'purchasePrice': purchasePrice,
      'image': image,
      'thumbnail': thumbnail,
      'categoryId': categoryId,
    };
  }

  String toJson() => json.encode(toMap());
}
