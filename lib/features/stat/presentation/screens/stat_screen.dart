import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/orders/orders.dart';
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

  int get sales => orderList
      .map((order) => order.orderItems)
      .fold(
        0,
        (sum, items) => sum + items.fold(0, (sum, item) => item.quantity),
      );

  int get orders => orderList.length;

  double get averageAmount => _sumOrderAmounts / orders;

  double get revenue => _sumOrderAmounts - _sumPurchasePrices;

  double get _sumOrderAmounts => orderList.fold(
    0,
    (sum, order) =>
        sum +
        order.orderItems.fold(
          0,
          (sum, item) => sum + (item.merch.price * item.quantity),
        ),
  );

  double get _sumPurchasePrices => orderList.fold(
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
            sales: sales,
            orders: orders,
            averageAmount: averageAmount,
            revenue: revenue,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          _PaymentMethodStat(),
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
    required this.sales,
    required this.orders,
    required this.averageAmount,
    required this.revenue,
  });

  final double averageAmount;
  final int orders;
  final double revenue;
  final int sales;

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
          value: NumberFormat().format(sales),
        ),
        StatInfoCard(
          name: S.of(context).orders,
          value: NumberFormat().format(orders),
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

class _PaymentMethodStat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
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
              Indicator(text: 'Payment Method 1', color: Colors.amber),
              SizedBox(height: 4),
              Indicator(text: 'Payment Method 2', color: Colors.amber),
              SizedBox(height: 4),
              Indicator(text: 'Payment Method 3', color: Colors.amber),
              SizedBox(height: 4),
            ],
          ),
        ],
      ),
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
    );
  }
}
