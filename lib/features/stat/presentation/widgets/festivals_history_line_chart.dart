import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:merchok/features/stat/stat.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:talker_flutter/talker_flutter.dart';

class FestivalsHistoryLineChart extends StatefulWidget {
  const FestivalsHistoryLineChart({super.key, required this.historyFestivals});

  final List<HistoryFestival> historyFestivals;

  @override
  State<FestivalsHistoryLineChart> createState() =>
      _FestivalsHistoryLineChartState();
}

class _FestivalsHistoryLineChartState extends State<FestivalsHistoryLineChart> {
  late final Map<String, _LineChartType> lineChartTypes;
  late String selectedLineChartTypeId;

  @override
  void initState() {
    super.initState();

    lineChartTypes = {
      'earned': _LineChartType(
        name: S.current.earned,
        values: widget.historyFestivals.map((f) => f.totalEarned).toList(),
        max: widget.historyFestivals
            .sorted((a, b) => a.totalEarned.compareTo(b.totalEarned))
            .last
            .totalEarned,
      ),
      'revenue': _LineChartType(
        name: S.current.revenue,
        values: widget.historyFestivals.map((f) => f.revenue).toList(),
        max: widget.historyFestivals
            .sorted((a, b) => a.revenue.compareTo(b.revenue))
            .last
            .revenue,
      ),
      'orders': _LineChartType(
        name: S.current.orders,
        values: widget.historyFestivals
            .map((f) => f.ordersCount.toDouble())
            .toList(),
        max: widget.historyFestivals
            .sorted((a, b) => a.ordersCount.compareTo(b.ordersCount))
            .last
            .ordersCount
            .toDouble(),
      ),
    };
    selectedLineChartTypeId = lineChartTypes.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(height: 12),
          Text(
            S.of(context).displayType,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          CupertinoSlidingSegmentedControl(
            groupValue: selectedLineChartTypeId,
            children: Map.fromEntries(
              List.generate(
                lineChartTypes.length,
                (i) => MapEntry(
                  lineChartTypes.keys.toList()[i],
                  Text(lineChartTypes.values.toList()[i].name),
                ),
              ),
            ),
            onValueChanged: (value) =>
                setState(() => selectedLineChartTypeId = value!),
          ),
          SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 24, 24, 12),
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: widget.historyFestivals.length.toDouble() + 1,
                  minY: 0,
                  maxY: lineChartTypes[selectedLineChartTypeId]!.max * 1.2,
                  gridData: FlGridData(
                    horizontalInterval:
                        lineChartTypes[selectedLineChartTypeId]!.max / 10,
                    verticalInterval: 1,
                  ),
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(sideTitles: SideTitles()),
                    rightTitles: AxisTitles(sideTitles: SideTitles()),
                    leftTitles: AxisTitles(
                      axisNameWidget: Text(S.of(context).earned),
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 48,
                      ),
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
                            widget
                                .historyFestivals[value.toInt() - 1]
                                .festival
                                .startDate
                                .day
                                .toString(),
                            // value.toString(),
                          );
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      curveSmoothness: 0.3,
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
                      spots: List.generate(widget.historyFestivals.length, (i) {
                        return FlSpot(
                          i + 1,
                          lineChartTypes[selectedLineChartTypeId]!.values[i],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LineChartType {
  _LineChartType({required this.name, required this.values, required this.max});

  final double max;
  final String name;
  final List<double> values;
}
