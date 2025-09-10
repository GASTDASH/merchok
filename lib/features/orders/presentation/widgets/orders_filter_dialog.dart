import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/generated/l10n.dart';

class OrdersFilterDialog extends StatefulWidget {
  const OrdersFilterDialog({super.key});

  @override
  State<OrdersFilterDialog> createState() => _OrdersFilterDialogState();
}

class _OrdersFilterDialogState extends State<OrdersFilterDialog> {
  final double maxAmount = 20000;
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();

  late RangeValues amountRange;
  DateTimeRange? dateRange;

  @override
  void initState() {
    super.initState();

    amountRange = RangeValues(0, maxAmount / 2);
    startController.text = amountRange.start.truncate().toString();
    endController.text = amountRange.end.truncate().toString();
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
              max: maxAmount,
              min: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MinMaxTextField(
                  controller: startController,
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
                MinMaxTextField(
                  controller: endController,
                  onChanged: (value) {
                    double? newEnd = double.tryParse(value);
                    if (newEnd == null || newEnd <= amountRange.start) {
                      return;
                    }
                    if (newEnd > maxAmount) newEnd = maxAmount;
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
                  SvgPicture.asset(
                    IconNames.right,
                    colorFilter: ColorFilter.mode(
                      theme.colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                    height: 16,
                  ),
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
                onTap: () {
                  context.pop();
                },
                child: Text(S.of(context).apply),
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
