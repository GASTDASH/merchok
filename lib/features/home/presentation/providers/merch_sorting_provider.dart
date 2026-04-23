import 'package:flutter/foundation.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/home/home.dart';

class MerchSortingProvider extends ChangeNotifier {
  static const List<MerchSorting> _merchSortingList = [
    MerchSorting(sortBy: MerchSortBy.alphabet, sortOrder: SortOrder.asc),
    MerchSorting(sortBy: MerchSortBy.alphabet, sortOrder: SortOrder.desc),
    // MerchSorting(sortBy: MerchSortBy.createdAt, sortOrder: SortOrder.asc),
    // MerchSorting(sortBy: MerchSortBy.createdAt, sortOrder: SortOrder.desc),
  ];

  int _index = 0;

  MerchSorting get merchSorting => _merchSortingList[_index];

  void changeMerchSorting() {
    _index++;
    if (_index == _merchSortingList.length) {
      _index = 0;
    }
    notifyListeners();
  }
}
