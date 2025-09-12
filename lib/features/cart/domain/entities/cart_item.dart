import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  const CartItem({required this.merchId, required this.quantity});

  final String merchId;
  final int quantity;

  CartItem copyWith({String? merchId, int? quantity}) => CartItem(
    merchId: merchId ?? this.merchId,
    quantity: quantity ?? this.quantity,
  );

  @override
  List<Object?> get props => [merchId, quantity];
}
