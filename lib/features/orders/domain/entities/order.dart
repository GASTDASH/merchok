// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/payment_method/payment_method.dart';

part 'order.g.dart';

@HiveType(typeId: 3)
class Order extends Equatable {
  const Order({
    required this.id,
    required this.orderItems,
    required this.createdAt,
    required this.festival,
    required this.paymentMethod,
  });

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final Festival festival;

  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<OrderItem> orderItems;

  @HiveField(4)
  final PaymentMethod paymentMethod;

  @override
  List<Object?> get props => [
    id,
    orderItems,
    createdAt,
    festival,
    paymentMethod,
  ];

  double get totalEarned => orderItems.fold<double>(0, (sum, orderItem) {
    return sum + orderItem.merch.price * orderItem.quantity;
  });

  double get totalSpent => orderItems.fold<double>(
    0,
    (sum, orderItem) =>
        sum + (orderItem.merch.purchasePrice ?? 0) * orderItem.quantity,
  );

  int get salesCount =>
      orderItems.fold(0, (sum, orderItem) => sum + orderItem.quantity);

  double get revenue => totalEarned - totalSpent;

  Order copyWith({
    String? id,
    List<OrderItem>? orderItems,
    DateTime? createdAt,
    Festival? festival,
    PaymentMethod? paymentMethod,
  }) {
    return Order(
      id: id ?? this.id,
      orderItems: orderItems ?? this.orderItems,
      createdAt: createdAt ?? this.createdAt,
      festival: festival ?? this.festival,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt.millisecondsSinceEpoch,
      'festival': festival.toMap(),
      'id': id,
      'orderItems': orderItems.map((x) => x.toMap()).toList(),
      'paymentMethod': paymentMethod.toMap(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      festival: Festival.fromMap(map['festival'] as Map<String, dynamic>),
      id: map['id'] as String,
      orderItems: List<OrderItem>.from(
        (map['orderItems'] as List<int>).map<OrderItem>(
          (x) => OrderItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      paymentMethod: PaymentMethod.fromMap(
        map['paymentMethod'] as Map<String, dynamic>,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
