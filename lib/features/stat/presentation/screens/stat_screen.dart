import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/stat/stat.dart';
import 'package:merchok/generated/l10n.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildListDelegate([
                StatCard(
                  onTap: () {},
                  text: S.of(context).generalSalesStatistics,
                  icon: IconNames.graph,
                ),
                StatCard(
                  onTap: () {},
                  text: S.of(context).popularMerch,
                  icon: IconNames.like,
                ),
                StatCard(
                  onTap: () {},
                  text: S.of(context).historyOfFestivals,
                  icon: IconNames.presentation,
                ),
                StatCard(
                  onTap: () {},
                  text: S.of(context).averageReceipt,
                  icon: IconNames.dollar,
                ),
                StatCard(
                  onTap: () {},
                  text: S.of(context).customerPreferences,
                  icon: IconNames.book,
                ),
                StatCard(
                  onTap: () {},
                  text: S.of(context).profit,
                  icon: IconNames.discount,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
