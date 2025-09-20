part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

final class OrderLoad extends OrderEvent {}

final class OrderAdd extends OrderEvent {
  const OrderAdd({
    required this.cartItems,
    required this.festival,
    required this.paymentMethod,
    required this.merchList,
  });

  final List<CartItem> cartItems;
  final Festival festival;
  final PaymentMethod paymentMethod;
  final List<Merch> merchList;

  @override
  List<Object> get props =>
      super.props..addAll([cartItems, festival, paymentMethod]);
}

final class OrderDelete extends OrderEvent {
  const OrderDelete({required this.orderId});

  final String orderId;

  @override
  List<Object> get props => super.props..addAll([orderId]);
}

final class OrderImport extends OrderEvent {
  const OrderImport({required this.orderList});

  final List<Order> orderList;

  @override
  List<Object> get props => super.props..addAll([orderList]);
}
