import 'package:merchok/features/orders/orders.dart';

class OrderRepositoryImpl implements OrderRepository {
  final Map<String, Order> orders = {};

  @override
  Future<List<Order>> getOrders() async => orders.values.toList();

  @override
  Future<void> addOrder(Order order) async {
    await Future.delayed(Duration(seconds: 2));
    orders.addAll({order.id: order});
  }

  @override
  Future<void> deleteOrder(String orderId) async => orders.remove(orderId);
}
