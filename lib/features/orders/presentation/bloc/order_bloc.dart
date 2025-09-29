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
            id: const Uuid().v4(),
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
          ),
        );
        add(OrderLoad());
      } catch (e) {
        emit(OrderError(error: e));
      }
    });
    on<OrderDelete>((event, emit) async {
      try {
        emit(OrderLoading(message: S.current.receiptDeleting));
        await _orderRepository.deleteOrder(event.orderId);
        add(OrderLoad());
      } catch (e) {
        emit(OrderError(error: e));
      }
    });
    on<OrderImport>((event, emit) async {
      try {
        emit(OrderLoading(message: S.current.receiptImporting));
        for (var order in event.orderList) {
          await _orderRepository.addOrder(order);
        }
        add(OrderLoad());
      } catch (e) {
        emit(OrderError(error: e));
      }
    });
    on<OrderUpdateAllMerch>((event, emit) async {
      try {
        emit(OrderLoading(message: S.current.receiptUpdating));

        final orderList = await _orderRepository.getOrders();

        for (var order in orderList) {
          bool needsUpdate = false;
          final updatedOrderItems = order.orderItems.map((item) {
            if (item.merch.id == event.updatedMerch.id) {
              needsUpdate = true;
              return item.copyWith(merch: event.updatedMerch);
            }
            return item;
          }).toList();

          if (needsUpdate) {
            await _orderRepository.addOrder(
              order.copyWith(orderItems: updatedOrderItems),
            );
          }
        }

        add(OrderLoad());
      } catch (e) {
        emit(OrderError(error: e));
      }
    });
  }
}
