import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OrderFilter extends Equatable {
  const OrderFilter({this.rangeValues, this.dateTimeRange});

  final DateTimeRange? dateTimeRange;
  final RangeValues? rangeValues;

  @override
  List<Object?> get props => [rangeValues, dateTimeRange];

  bool get isEmpty => rangeValues == null && dateTimeRange == null;

  bool get isNotEmpty => !isEmpty;
}
