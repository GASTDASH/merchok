import 'package:flutter/material.dart' show IconData;
import 'package:merchok/core/core.dart';

enum MerchSortBy {
  alphabet(icon: AppIcons.font),
  createdAt(icon: AppIcons.clock);

  final IconData icon;

  const MerchSortBy({required this.icon});
}

class MerchSorting {
  const MerchSorting({required this.sortBy, required this.sortOrder});

  final MerchSortBy sortBy;
  final SortOrder sortOrder;
}
