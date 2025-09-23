// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}
