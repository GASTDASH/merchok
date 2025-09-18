import 'package:flutter/foundation.dart';
import 'package:merchok/features/orders/orders.dart';

class OrderSortingProvider extends ChangeNotifier {
  static const List<OrderSorting> _orderSortingList = [
    OrderSorting(sortBy: OrderSortBy.createdAt, sortOrder: SortOrder.asc),
    OrderSorting(sortBy: OrderSortBy.createdAt, sortOrder: SortOrder.desc),
    OrderSorting(sortBy: OrderSortBy.totalAmount, sortOrder: SortOrder.asc),
    OrderSorting(sortBy: OrderSortBy.totalAmount, sortOrder: SortOrder.desc),
  ];

  int _index = 0;
  OrderSorting _orderSorting = _orderSortingList[0];

  OrderSorting get orderSorting => _orderSorting;

  void changeOrderSorting() {
    if (_index + 1 == _orderSortingList.length) {
      _index = 0;
    } else {
      _index++;
    }
    _orderSorting = _orderSortingList[_index];
    notifyListeners();
  }
}
