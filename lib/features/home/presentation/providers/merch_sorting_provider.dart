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
  MerchSorting _merchSorting = _merchSortingList[0];

  MerchSorting get merchSorting => _merchSorting;

  void changeMerchSorting() {
    if (_index + 1 == _merchSortingList.length) {
      _index = 0;
    } else {
      _index++;
    }
    _merchSorting = _merchSortingList[_index];
    notifyListeners();
  }
}
