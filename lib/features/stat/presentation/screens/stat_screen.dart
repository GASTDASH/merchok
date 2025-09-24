import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/payment_method/payment_method.dart';
import 'package:merchok/features/stat/stat.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return LoadingBanner(message: state.message);
              } else if (state is OrderLoaded) {
                return _StatList(orderList: state.orderList);
              } else if (state is OrderError) {
                return ErrorBanner(message: state.error.toString());
              } else if (state is OrderInitial) {
                return SliverFillRemaining();
              }
              return UnexpectedStateBanner();
            },
          ),
        ],
      ),
    );
  }
}

class _StatList extends StatelessWidget {
  const _StatList({required this.orderList});

  final List<Order> orderList;

  int get salesCount =>
      orderList.fold(0, (sum, order) => sum + order.salesCount);

  int get ordersCount => orderList.length;

  double get averageAmount =>
      _sumTotalEarned / ordersCount.clamp(1, double.infinity);

  double get revenue => _sumTotalEarned - _sumTotalSpent;

  double get _sumTotalEarned =>
      orderList.fold(0, (sum, order) => sum + order.totalEarned);

  double get _sumTotalSpent => orderList.fold(
    0,
    (sum, order) =>
        sum +
        order.orderItems.fold(
          0,
          (sum, item) => sum + (item.merch.purchasePrice ?? 0 * item.quantity),
        ),
  );

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(24),
      sliver: SliverMainAxisGroup(
        slivers: [
          _GeneralStat(
            salesCount: salesCount,
            ordersCount: ordersCount,
            averageAmount: averageAmount,
            revenue: revenue,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          PaymentMethodStat(orderList: orderList),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          _OtherStatCards(),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                if (orderState.orderList.isEmpty) {
                  Fluttertoast.showToast(msg: S.of(context).noReceipts);
                  return;
                }
                if (merchState is! MerchLoaded) {
                  Fluttertoast.showToast(msg: S.of(context).merchIsNotLoaded);
                  return;
                }
                if (merchState.merchList.isEmpty) {
                  Fluttertoast.showToast(msg: S.of(context).noMerch);
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
