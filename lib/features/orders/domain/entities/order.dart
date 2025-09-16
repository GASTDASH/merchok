// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/payment_method/payment_method.dart';

class Order extends Equatable {
  const Order({
    required this.id,
    required this.orderItems,
    required this.createdAt,
    required this.festival,
    required this.paymentMethod,
    required this.totalAmount,
  });

  final String id;
  final List<OrderItem> orderItems;
  final DateTime createdAt;
  final Festival festival;
  final PaymentMethod paymentMethod;
  final double totalAmount;

  Order copyWith({
    String? id,
    List<OrderItem>? orderItems,
    DateTime? createdAt,
    Festival? festival,
    PaymentMethod? paymentMethod,
    double? totalAmount,
  }) {
    return Order(
      id: id ?? this.id,
      orderItems: orderItems ?? this.orderItems,
      createdAt: createdAt ?? this.createdAt,
      festival: festival ?? this.festival,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  @override
  List<Object?> get props => [
    id,
    orderItems,
    createdAt,
    festival,
    paymentMethod,
    totalAmount,
  ];
}
