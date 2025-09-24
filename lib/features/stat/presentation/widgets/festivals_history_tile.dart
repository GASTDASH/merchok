import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/stat/stat.dart';
import 'package:merchok/generated/l10n.dart';

class FestivalsHistoryTile extends StatelessWidget {
  const FestivalsHistoryTile({super.key, required this.festivalHistory});

  final HistoryFestival festivalHistory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      spacing: 12,
      children: [
        Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              festivalHistory.festival.name,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              spacing: 8,
              children: [
                Text(festivalHistory.festival.startDate.toCompactString()),
                BaseSvgIcon(context, IconNames.right, height: 12),
                Text(festivalHistory.festival.endDate.toCompactString()),
              ],
            ),
          ],
        ),
        DefaultTextStyle(
          style: theme.textTheme.titleLarge ?? TextStyle(),
          child: Column(
            spacing: 12,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${S.of(context).earned}: '),
                  Text(
                    NumberFormat.simpleCurrency(
                      decimalDigits: 0,
                    ).format(festivalHistory.totalEarned),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${S.of(context).totalOrders}: '),
                  Text('${festivalHistory.ordersCount}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${S.of(context).totalSales}: '),
                  Text('${festivalHistory.salesCount}'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
