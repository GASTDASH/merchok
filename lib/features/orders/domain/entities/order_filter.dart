import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OrderFilter extends Equatable {
  const OrderFilter({this.rangeValues, this.dateTimeRange});

  final RangeValues? rangeValues;
  final DateTimeRange? dateTimeRange;

  bool get isEmpty => rangeValues == null && dateTimeRange == null;
  bool get isNotEmpty => !isEmpty;

  @override
  List<Object?> get props => [rangeValues, dateTimeRange];
}
