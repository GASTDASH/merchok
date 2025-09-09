import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class ReceiptWidget extends StatelessWidget {
  const ReceiptWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      spacing: 12,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: S.of(context).receiptFrom,
                style: theme.textTheme.titleLarge,
                children: [
                  TextSpan(
                    text: '02.09 ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '21:54'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                IconNames.delete,
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
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
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text('1', style: theme.textTheme.titleLarge),
                ),
                Text(
                  S.of(context).merchDefaultName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '100 ₽',
                  textAlign: TextAlign.right,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text('4', style: theme.textTheme.titleLarge),
                ),
                Text(
                  S.of(context).merchDefaultName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '50 ₽',
                  textAlign: TextAlign.right,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(S.of(context).total, style: theme.textTheme.titleLarge),
            Text(
              '300 ₽',
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
