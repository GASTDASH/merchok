import 'package:flutter/foundation.dart';
import 'package:merchok/features/merch/merch.dart';

class MerchCardStyleProvider extends ChangeNotifier {
  static const List<MerchCardStyle> _styles = [.standard, .compact];

  MerchCardStyle get style => _styles[_index];

  int _index = 0;

  void changeStyle() {
    _index++;
    if (_index == _styles.length) {
      _index = 0;
    }
    notifyListeners();
  }
}
