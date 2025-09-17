import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/cart/cart.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/payment_method/payment_method.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:uuid/uuid.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;

  OrderBloc({required OrderRepository orderRepository})
    : _orderRepository = orderRepository,
      super(OrderInitial()) {
    on<OrderLoad>((event, emit) async {
      try {
        emit(OrderLoading(message: S.current.receiptsLoading));
        final orderList = await _orderRepository.getOrders();
        emit(OrderLoaded(orderList: orderList));
      } catch (e) {
        emit(OrderError(error: e));
      }
    });
    on<OrderAdd>((event, emit) async {
      try {
        emit(OrderLoading(message: S.current.receiptSaving));
        await _orderRepository.addOrder(
          Order(
            id: Uuid().v4(),
            orderItems: event.cartItems
                .map(
                  (cartItem) => OrderItem.fromCartItem(
                    cartItem,
                    event.merchList.firstWhere((m) => m.id == cartItem.merchId),
                  ),
                )
                .toList(),
            createdAt: DateTime.now(),
            festival: event.festival,
            paymentMethod: event.paymentMethod,
            totalAmount: event.cartItems.fold<double>(0, (sum, cartItem) {
              final merch = event.merchList.firstWhere(
                (m) => m.id == cartItem.merchId,
              );
              return sum + merch.price * cartItem.quantity;
            }),
          ),
        );
        add(OrderLoad());
      } catch (e) {
        emit(OrderError(error: e));
      }
    });
  }
}
