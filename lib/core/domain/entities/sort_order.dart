import 'package:flutter/material.dart' show IconData;
import 'package:merchok/core/core.dart';

enum SortOrder {
  asc(icon: AppIcons.sortAsc),
  desc(icon: AppIcons.sortDesc);

  final IconData icon;

  const SortOrder({required this.icon});
}
