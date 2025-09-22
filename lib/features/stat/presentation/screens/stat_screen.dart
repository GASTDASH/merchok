import 'package:fl_chart/fl_chart.dart';
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
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                value: 43,
                                title: '43 %',
                                color: Colors.amber,
                                radius: 50,
                                titleStyle: theme.textTheme.titleMedium,
                              ),
                              PieChartSectionData(
                                value: 32,
                                title: '32 %',
                                color: Colors.amber,
                                radius: 50,
                                titleStyle: theme.textTheme.titleMedium,
                              ),
                              PieChartSectionData(
                                value: 26,
                                title: '26 %',
                                color: Colors.amber,
                                radius: 50,
                                titleStyle: theme.textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Indicator(
                            text: 'Payment Method 1',
                            color: Colors.amber,
                          ),
                          SizedBox(height: 4),
                          Indicator(
                            text: 'Payment Method 2',
                            color: Colors.amber,
                          ),
                          SizedBox(height: 4),
                          Indicator(
                            text: 'Payment Method 3',
                            color: Colors.amber,
                          ),
                          SizedBox(height: 4),
                        ],
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
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
