import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/stat/stat.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:talker_flutter/talker_flutter.dart';

class FestivalsHistoryLineChart extends StatelessWidget {
  const FestivalsHistoryLineChart({
    super.key,
    required this.max,
    required this.historyFestivals,
  });

  final double max;
  final List<HistoryFestival> historyFestivals;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 250,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 24, 24, 12),
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: historyFestivals.length.toDouble() + 1,
              minY: 0,
              maxY: max + 100,
              gridData: FlGridData(
                horizontalInterval: max / 10,
                verticalInterval: 1,
              ),
              titlesData: FlTitlesData(
                topTitles: AxisTitles(sideTitles: SideTitles()),
                rightTitles: AxisTitles(sideTitles: SideTitles()),
                leftTitles: AxisTitles(
                  axisNameWidget: Text(S.of(context).earned),
                  sideTitles: SideTitles(showTitles: true, reservedSize: 48),
                ),
                bottomTitles: AxisTitles(
                  axisNameWidget: Text(S.of(context).dateOfTheEvent),
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 24,
                    minIncluded: false,
                    maxIncluded: false,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      GetIt.I<Talker>().debug(value);
                      return Text(
                        historyFestivals[value.toInt() - 1].festival.startDate
                            .toCompactString(),
                        // value.toString(),
                      );
                    },
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  curveSmoothness: 0.25,
                  gradient: LinearGradient(
                    begin: AlignmentGeometry.bottomLeft,
                    end: AlignmentGeometry.topRight,
                    colors: [
                      HSLColor.fromColor(
                        Theme.of(context).primaryColor,
                      ).withLightness(0.42).toColor(),
                      Theme.of(context).primaryColor,
                    ],
                  ),
                  spots: [
                    FlSpot(0, 0),
                    ...List.generate(historyFestivals.length, (i) {
                      return FlSpot(i + 1, historyFestivals[i].totalEarned);
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
