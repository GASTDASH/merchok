import 'package:hive/hive.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/orders/orders.dart';

class OrderRepositoryImpl implements OrderRepository {
  final Box<Order> orderBox = Hive.box(HiveBoxesNames.orders);

  @override
  Future<List<Order>> getOrders() async => orderBox.values.toList();

  @override
  Future<void> addOrder(Order order) async {
    await orderBox.put(order.id, order);
  }

  @override
  Future<void> deleteOrder(String orderId) async =>
      await orderBox.delete(orderId);
}
