import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/festival/domain/entities/festival.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/stat/stat.dart';
import 'package:merchok/generated/l10n.dart';

class FestivalsHistoryScreen extends StatelessWidget {
  const FestivalsHistoryScreen({super.key});

  List<HistoryFestival> _toHistory(
    List<Festival> festivals,
    List<Order> sortedOrderList,
  ) => festivals.map((festival) {
    final ordersOnFestival = sortedOrderList.where(
      (order) => order.festival == festival,
    );
    final totalEarned = ordersOnFestival.fold<double>(
      0,
      (sum, order) => sum + order.totalEarned,
    );
    return HistoryFestival(
      festival: festival,
      totalEarned: totalEarned,
      ordersCount: ordersOnFestival.length,
      salesCount: ordersOnFestival.fold(
        0,
        (sum, order) =>
            sum + order.orderItems.fold(0, (sum, item) => sum + item.quantity),
      ),
      revenue:
          totalEarned -
          ordersOnFestival.fold(0, (sum, order) => sum + order.revenue),
    );
  }).toList();

  List<Festival> _getFestivals(List<Order> orderList) => orderList
      .map((order) => order.festival)
      .toSet()
      .sorted((a, b) => a.startDate.compareTo(b.startDate))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BaseSliverAppBar(title: S.of(context).historyOfFestivals),
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoaded) {
                final sortedOrderList = state.orderList.sorted(
                  (a, b) => a.totalEarned.compareTo(b.totalEarned),
                );
                final historyFestivals = _toHistory(
                  _getFestivals(state.orderList),
                  sortedOrderList,
                );

                return SliverMainAxisGroup(
                  slivers: [
                    FestivalsHistoryLineChart(
                      historyFestivals: historyFestivals,
                    ),
                    PastFestivalsList(
                      historyFestivals: historyFestivals.reversed.toList(),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 32)),
                  ],
                );
              } else {
                return SliverFillRemaining();
              }
            },
          ),
        ],
      ),
    );
  }
}
