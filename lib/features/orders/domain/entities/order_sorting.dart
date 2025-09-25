import 'package:flutter/material.dart' show IconData;
import 'package:merchok/core/core.dart';

enum OrderSortBy {
  createdAt(icon: AppIcons.clock),
  totalAmount(icon: AppIcons.creditCard);

  final IconData icon;

  const OrderSortBy({required this.icon});
}

class OrderSorting {
  const OrderSorting({required this.sortBy, required this.sortOrder});

  final OrderSortBy sortBy;
  final SortOrder sortOrder;
}
