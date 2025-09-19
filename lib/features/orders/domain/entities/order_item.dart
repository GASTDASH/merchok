// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:merchok/features/cart/cart.dart';
import 'package:merchok/features/merch/merch.dart';

part 'order_item.g.dart';

@HiveType(typeId: 4)
class OrderItem extends Equatable {
  const OrderItem({required this.merch, required this.quantity});

  @HiveField(0)
  final Merch merch;

  @HiveField(1)
  final int quantity;

  OrderItem copyWith({Merch? merch, int? quantity}) {
    return OrderItem(
      merch: merch ?? this.merch,
      quantity: quantity ?? this.quantity,
    );
  }

  factory OrderItem.fromCartItem(CartItem cartItem, Merch merch) =>
      OrderItem(merch: merch, quantity: cartItem.quantity);

  @override
  List<Object?> get props => [merch, quantity];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'merch': merch.toMap(), 'quantity': quantity};
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      merch: Merch.fromMap(map['merch'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
