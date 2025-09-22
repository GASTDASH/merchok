import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/stat/stat.dart';
import 'package:merchok/generated/l10n.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.5,
                  ),
                  delegate: SliverChildListDelegate([
                    StatInfoCard(name: 'Продаж', value: '1,234'),
                    StatInfoCard(name: 'Заказов', value: '345'),
                    StatInfoCard(name: 'Средний чек', value: '1,200 ₽'),
                    StatInfoCard(name: 'Выручка', value: '2,850 ₽'),
                  ]),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  delegate: SliverChildListDelegate([
                    StatButtonCard(
                      onTap: () {},
                      text: S.of(context).historyOfFestivals,
                      icon: IconNames.graph,
                    ),
                    StatButtonCard(
                      onTap: () {},
                      text: S.of(context).popularMerch,
                      icon: IconNames.like,
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
