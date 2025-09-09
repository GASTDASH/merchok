import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/export/export.dart';
import 'package:merchok/generated/l10n.dart';

class ExportScreen extends StatelessWidget {
  const ExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BaseSliverAppBar(title: S.of(context).dataExport),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            sliver: SliverList.list(
              children: [
                Text(
                  S.of(context).whatToExport,
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                ExportCard(
                  onTap: () {},
                  text: S.of(context).allAtOnce,
                  icon: IconNames.puzzle,
                ),
                SizedBox(height: 12),
                Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ExportCard(
                        onTap: () {},
                        text: S.of(context).merch,
                        icon: IconNames.cart,
                      ),
                    ),
                    Expanded(
                      child: ExportCard(
                        onTap: () {},
                        text: S.of(context).orderHistory,
                        icon: IconNames.history,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ExportCard(
                        onTap: () {},
                        text: S.of(context).paymentMethods,
                        icon: IconNames.money,
                      ),
                    ),
                    Expanded(
                      child: ExportCard(
                        onTap: () {},
                        text: S.of(context).festivals,
                        icon: IconNames.event,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
