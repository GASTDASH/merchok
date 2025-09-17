import 'package:merchok/core/core.dart';

enum OrderSortBy {
  createdAt(icon: IconNames.clock),
  totalAmount(icon: IconNames.creditCard);

  final String icon;

  const OrderSortBy({required this.icon});
}

enum SortOrder {
  asc(icon: IconNames.sortAsc),
  desc(icon: IconNames.sortDesc);

  final String icon;

  const SortOrder({required this.icon});
}

class OrderSorting {
  const OrderSorting({required this.sortBy, required this.sortOrder});

  final OrderSortBy sortBy;
  final SortOrder sortOrder;
}
