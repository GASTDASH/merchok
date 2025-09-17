import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/generated/l10n.dart';

class OrdersFilterDialog extends StatefulWidget {
  const OrdersFilterDialog({
    super.key,
    this.previousFilter,
    required this.maxAmount,
  });

  final OrderFilter? previousFilter;
  final double maxAmount;

  @override
  State<OrdersFilterDialog> createState() => _OrdersFilterDialogState();
}

class _OrdersFilterDialogState extends State<OrdersFilterDialog> {
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();

  late RangeValues amountRange;
  DateTimeRange? dateRange;

  @override
  void initState() {
    super.initState();

    amountRange = RangeValues(0, widget.maxAmount);
    startController.text = amountRange.start.truncate().toString();
    endController.text = amountRange.end.truncate().toString();

    final previousFilter = widget.previousFilter;
    if (previousFilter != null) {
      final rangeValues = previousFilter.rangeValues;
      if (rangeValues != null) {
        amountRange = RangeValues(rangeValues.start, rangeValues.end);
      }

      final dateTimeRange = previousFilter.dateTimeRange;
      if (dateTimeRange != null) dateRange = dateTimeRange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text(
                '${S.of(context).orderAmount}:',
                style: theme.textTheme.titleLarge,
              ),
            ),
            RangeSlider(
              values: amountRange,
              onChanged: (value) => setState(
                () => amountRange = RangeValues(
                  value.start.truncateToDouble(),
                  value.end.truncateToDouble(),
                ),
              ),
              max: widget.maxAmount,
              min: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _MinMaxTextField(
                  controller: startController
                    ..text = amountRange.start.truncateIfInt(),
                  onChanged: (value) {
                    double? newStart = double.tryParse(value);
                    if (newStart == null || newStart >= amountRange.end) {
                      return;
                    }
                    if (newStart < 0) newStart = 0;
                    amountRange = RangeValues(newStart, amountRange.end);
                    setState(() {});
                  },
                ),
                Text('₽', style: theme.textTheme.titleLarge),
                _MinMaxTextField(
                  controller: endController
                    ..text = amountRange.end.truncateIfInt(),
                  onChanged: (value) {
                    double? newEnd = double.tryParse(value);
                    if (newEnd == null || newEnd <= amountRange.start) {
                      return;
                    }
                    if (newEnd > widget.maxAmount) newEnd = widget.maxAmount;
                    amountRange = RangeValues(amountRange.start, newEnd);
                    setState(() {});
                  },
                ),
              ],
            ),
            SizedBox(height: 24),
            Divider(),
            SizedBox(height: 24),
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text(
                '${S.of(context).orderCreationPeriod}:',
                style: theme.textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 48,
              child: BaseButton.outlined(
                color: theme.colorScheme.onSurface,
                onTap: () async {
                  final newDateRange = await showCreationDateRangePicker(
                    context,
                  );
                  if (newDateRange == null) return;
                  setState(() => dateRange = newDateRange);
                },
                child: Text(S.of(context).selectPeriod),
              ),
            ),
            SizedBox(height: 16),
            if (dateRange != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    dateRange!.start.toCompactString(),
                    style: theme.textTheme.bodyLarge,
                  ),
                  BaseSvgIcon(context, IconNames.right, height: 16),
                  Text(
                    dateRange!.end.toCompactString(),
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            if (dateRange != null) SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            SizedBox(
              height: 48,
              child: BaseButton(
                onTap: () => context.pop(
                  OrderFilter(
                    rangeValues: amountRange,
                    dateTimeRange: dateRange,
                  ),
                ),
                child: Text(S.of(context).apply),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 48,
              child: BaseButton.outlined(
                onTap: () => context.pop(OrderFilter()),
                color: theme.colorScheme.onSurface,
                child: Text(S.of(context).clearFilter),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTimeRange<DateTime>?> showCreationDateRangePicker(
    BuildContext context,
  ) {
    return showDateRangePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );
  }
}

class _MinMaxTextField extends StatelessWidget {
  const _MinMaxTextField({this.controller, this.onChanged});

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
