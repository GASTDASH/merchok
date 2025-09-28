import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:merchok/features/festival/festival.dart';

class OrderFilter extends Equatable {
  const OrderFilter({this.rangeValues, this.dateTimeRange, this.festival});

  final DateTimeRange? dateTimeRange;
  final RangeValues? rangeValues;
  final Festival? festival;

  @override
  List<Object?> get props => [rangeValues, dateTimeRange];

  bool get isEmpty => rangeValues == null && dateTimeRange == null;

  bool get isNotEmpty => !isEmpty;
}
