// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:merchok/features/cart/cart.dart';
import 'package:merchok/features/merch/merch.dart';

class OrderItem extends Equatable {
  const OrderItem({required this.merch, required this.quantity});

  final Merch merch;
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
}
