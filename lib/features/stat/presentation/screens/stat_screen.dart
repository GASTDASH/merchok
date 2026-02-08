import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/current_festival/current_festival.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/payment_method/payment_method.dart';
import 'package:merchok/features/stat/stat.dart';
import 'package:merchok/features/stock/stock.dart';
import 'package:merchok/generated/l10n.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({super.key});

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  @override
  void initState() {
    super.initState();

    context.read<OrderBloc>().add(OrderLoad());
    context.read<PaymentMethodBloc>().add(PaymentMethodLoad());
    context.read<MerchBloc>().add(MerchLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BlocBuilder<CurrentFestivalCubit, Festival?>(
            builder: (context, currentFestival) {
              if (currentFestival == null) {
                return InfoBanner.icon(
                  text: S.of(context).festivalNotSelected,
                  icon: AppIcons.calendar,
                );
              }
              return BlocBuilder<OrderBloc, OrderState>(
                builder: (context, orderState) {
                  return BlocBuilder<StockBloc, StockState>(
                    builder: (context, stockState) {
                      return BlocBuilder<MerchBloc, MerchState>(
                        builder: (context, merchState) {
                          if (orderState is OrderLoading ||
                              stockState is StockLoading ||
                              merchState is MerchLoading) {
                            return LoadingBanner(
                              message: orderState is OrderLoading
                                  ? orderState.message
                                  : stockState is StockLoading
                                  ? stockState.message
                                  : (merchState as MerchLoading).message,
                            );
                          }
                          if (orderState is OrderLoaded &&
                              stockState is StockLoaded &&
                              merchState is MerchLoaded) {
                            return _StatList(
                              orderList: orderState.orderList,
                              stockItems: stockState.stockItems,
                              merchList: merchState.merchList,
                            );
                          }
                          if (orderState is OrderError ||
                              stockState is StockError ||
                              merchState is MerchError) {
                            return ErrorBanner(
                              message: orderState is OrderError
                                  ? orderState.error.toString()
                                  : stockState is StockError
                                  ? stockState.error.toString()
                                  : (merchState as MerchError).error.toString(),
                            );
                          }
                          if (orderState is OrderInitial ||
                              stockState is StockInitial ||
                              merchState is MerchInitial) {
                            return const SliverFillRemaining();
                          }
                          return const UnexpectedStateBanner();
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatList extends StatelessWidget {
  const _StatList({
    required this.orderList,
    required this.stockItems,
    required this.merchList,
  });

  final List<Order> orderList;
  final List<StockItem> stockItems;
  final List<Merch> merchList;

  Future<Map<String, dynamic>> getGeneralStat() async {
    log('getGeneralStat() called');
    final data = compute((_) => _getGeneralStatCompute(), null);
    log('got generalStat');
    return data;
  }

  int get _salesCount =>
      orderList.fold(0, (sum, order) => sum + order.salesCount);

  int get _ordersCount => orderList.length;

  double get _averageAmount =>
      _sumTotalEarned / _ordersCount.clamp(1, double.infinity);

  double get _revenue => _sumTotalEarned - _sumTotalSpentViaStock;

  double get _sumTotalEarned =>
      orderList.fold(0, (sum, order) => sum + order.totalEarned);

  @Deprecated('Use _sumTotalSpentViaStock instead')
  double get _sumTotalSpent => orderList.fold(
    0,
    (sum, order) =>
        sum +
        order.orderItems.fold(
          0,
          (sum, item) => sum + (item.merch.purchasePrice ?? 0 * item.quantity),
        ),
  );

  double get _sumTotalSpentViaStock {
    double totalSpent = 0;

    final Map<String, Merch> merchById = {
      for (final merch in merchList) merch.id: merch,
    };

    for (final item in stockItems) {
      if (merchById[item.merchId] == null) continue;

      if (merchById[item.merchId]!.purchasePrice != null) {
        totalSpent += merchById[item.merchId]!.purchasePrice! * item.quantity;
      }
    }

    log(totalSpent.toString());

    return totalSpent;
  }

  Map<String, dynamic> _getGeneralStatCompute() => {
    'salesCount': _salesCount,
    'ordersCount': _ordersCount,
    'averageAmount': _averageAmount,
    'revenue': _revenue,
  };

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(24),
      sliver: FutureBuilder(
        future: getGeneralStat(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingBanner(message: S.of(context).loading);
          }
          if (snapshot.hasError) {
            return ErrorBanner(message: snapshot.error.toString());
          }
          if (snapshot.hasData) {
            return SliverMainAxisGroup(
              slivers: [
                _GeneralStat(
                  salesCount: snapshot.data!['salesCount'],
                  ordersCount: snapshot.data!['ordersCount'],
                  averageAmount: snapshot.data!['averageAmount'],
                  revenue: snapshot.data!['revenue'],
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                PaymentMethodStat(orderList: orderList),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                _OtherStatCards(),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            );
          } else {
            return InfoBanner(text: S.of(context).noDataToDisplay);
          }
        },
      ),
    );
  }
}

class _GeneralStat extends StatelessWidget {
  const _GeneralStat({
    required this.salesCount,
    required this.ordersCount,
    required this.averageAmount,
    required this.revenue,
  });

  final double averageAmount;
  final int ordersCount;
  final double revenue;
  final int salesCount;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      delegate: SliverChildListDelegate([
        StatInfoCard(
          name: S.of(context).sales,
          value: NumberFormat().format(salesCount),
        ),
        StatInfoCard(
          name: S.of(context).orders,
          value: NumberFormat().format(ordersCount),
        ),
        StatInfoCard(
          name: S.of(context).averageReceipt,
          value: NumberFormat.simpleCurrency(
            decimalDigits: 0,
          ).format(averageAmount),
        ),
        StatInfoCard(
          name: S.of(context).revenue,
          value: NumberFormat.simpleCurrency(decimalDigits: 0).format(revenue),
        ),
      ]),
    );
  }
}

class _OtherStatCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      delegate: SliverChildListDelegate([
        Builder(
          builder: (context) {
            final state = context.watch<OrderBloc>().state;
            return StatButtonCard(
              onTap: () {
                if (state is! OrderLoaded) {
                  Fluttertoast.showToast(msg: S.of(context).ordersIsNotLoaded);
                  return;
                }
                if (state.orderList.isEmpty) {
                  Fluttertoast.showToast(msg: S.of(context).noReceipts);
                  return;
                }
                context.push('/festivals_history');
              },
              text: S.of(context).historyOfFestivals,
              icon: IconNames.graph,
            );
          },
        ),
        Builder(
          builder: (context) {
            final orderState = context.watch<OrderBloc>().state;
            final merchState = context.watch<MerchBloc>().state;
            return StatButtonCard(
              onTap: () {
                if (orderState is! OrderLoaded) {
                  Fluttertoast.showToast(msg: S.of(context).ordersIsNotLoaded);
                  return;
                }

                if (merchState is! MerchLoaded) {
                  Fluttertoast.showToast(msg: S.of(context).merchIsNotLoaded);
                  return;
                }
                if (orderState.orderList.isEmpty &&
                    merchState.merchList.isEmpty) {
                  Fluttertoast.showToast(
                    msg:
                        '${S.of(context).noReceipts}\n${S.of(context).noMerch}',
                  );
                  return;
                }
                context.push('/popular_merch');
              },
              text: S.of(context).popularMerch,
              icon: IconNames.like,
            );
          },
        ),
      ]),
    );
  }
}
