import 'package:merchok/core/core.dart';

enum SortOrder {
  asc(icon: IconNames.sortAsc),
  desc(icon: IconNames.sortDesc);

  final String icon;

  const SortOrder({required this.icon});
}
