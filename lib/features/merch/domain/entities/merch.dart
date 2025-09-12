import 'dart:typed_data';

import 'package:equatable/equatable.dart';

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

  final String id;
  final String name;
  final String? description;
  final double price;
  final double? purchasePrice;
  final Uint8List? image;
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
}
