import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:provider/provider.dart';

class ReceiptWidget extends StatelessWidget {
  const ReceiptWidget({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      spacing: 12,
      children: [
        Column(
          spacing: 4,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: RichText(
                        text: TextSpan(
                          text: S.of(context).receiptFrom,
                          style: theme.textTheme.titleLarge,
                          children: [
                            TextSpan(
                              text: order.createdAt.toCompactString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' ${order.createdAt.toTime()}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.read<OrderBloc>().add(
                    OrderDelete(orderId: order.id),
                  ),
                  child: Icon(AppIcons.delete),
                ),
              ],
            ),
            Row(
              spacing: 8,
              children: [Icon(AppIcons.calendar), Text(order.festival.name)],
            ),
          ],
        ),
        Table(
          columnWidths: {
            0: FixedColumnWidth(64),
            1: FlexColumnWidth(),
            2: IntrinsicColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: List.generate(order.orderItems.length, (i) {
            final orderItem = order.orderItems[i];
            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    '${orderItem.quantity}',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                Text(
                  orderItem.merch.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  orderItem.merch.price.truncateIfInt(),
                  textAlign: TextAlign.right,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(S.of(context).total, style: theme.textTheme.titleLarge),
            Text(
              '${order.totalEarned.truncateIfInt()} ₽',
              textAlign: TextAlign.right,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
