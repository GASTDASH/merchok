import 'package:merchok/features/orders/orders.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrders();
  Future<void> addOrder(Order order);
  Future<void> deleteOrder(String orderId);
}
