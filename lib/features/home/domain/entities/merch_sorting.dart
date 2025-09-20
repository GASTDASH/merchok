import 'package:merchok/core/core.dart';

enum MerchSortBy {
  alphabet(icon: IconNames.font),
  createdAt(icon: IconNames.clock);

  final String icon;

  const MerchSortBy({required this.icon});
}

class MerchSorting {
  const MerchSorting({required this.sortBy, required this.sortOrder});

  final MerchSortBy sortBy;
  final SortOrder sortOrder;
}
