import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/generated/l10n.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  OrderFilter? currentFilter;
  final orderSortingProvider = OrderSortingProvider();

  @override
  void initState() {
    super.initState();

    context.read<OrderBloc>().add(OrderLoad());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(24).copyWith(top: 16),
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    spacing: 12,
                    children: [
                      BaseButton.outlined(
                        onTap: () async {
                          final filter = await showOrdersFilterDialog(
                            context,
                            currentFilter,
                          );
                          if (filter == null) return;
                          if (filter.rangeValues == null &&
                              filter.dateTimeRange == null) {
                            return setState(() => currentFilter = null);
                          }
                          setState(() => currentFilter = filter);
                        },
                        color: theme.colorScheme.onSurface,
                        backgroundColor: currentFilter != null
                            ? theme.hintColor.withAlpha(32)
                            : null,
                        child: Row(
                          spacing: 8,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(S.of(context).filter),
                            BaseSvgIcon(context, IconNames.filter),
                          ],
                        ),
                      ),
                      ListenableBuilder(
                        listenable: orderSortingProvider,
                        builder: (context, _) {
                          return BaseButton.outlined(
                            onTap: () =>
                                orderSortingProvider.changeOrderSorting(),
                            color: theme.colorScheme.onSurface,
                            child: Row(
                              spacing: 8,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(S.of(context).sorting),
                                BaseSvgIcon(
                                  context,
                                  orderSortingProvider.orderSorting.sortBy.icon,
                                ),
                                BaseSvgIcon(
                                  context,
                                  orderSortingProvider
                                      .orderSorting
                                      .sortOrder
                                      .icon,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    if (state is OrderLoading) {
                      return LoadingBanner(message: state.message);
                    } else if (state is OrderLoaded) {
                      if (state.orderList.isNotEmpty) {
                        List<Order> filteredOrderList = filterOrderList(
                          state.orderList,
                        );

                        if (filteredOrderList.isEmpty &&
                            currentFilter != null) {
                          return InfoBanner(
                            text: S.of(context).noMatchingOrders,
                          );
                        }

                        return SliverList.separated(
                          itemCount: filteredOrderList.length,
                          separatorBuilder: (context, index) =>
                              Divider(indent: 32, endIndent: 32, height: 48),
                          itemBuilder: (context, index) =>
                              ReceiptWidget(order: filteredOrderList[index]),
                        );
                      } else {
                        return InfoBanner(text: S.of(context).noReceipts);
                      }
                    } else if (state is OrderError) {
                      return ErrorBanner(message: state.error.toString());
                    } else if (state is OrderInitial) {
                      return SliverFillRemaining(hasScrollBody: false);
                    }
                    return UnexpectedStateBanner();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Order> filterOrderList(List<Order> orderList) {
    List<Order> filteredOrderList = orderList;

    if (currentFilter != null) {
      if (currentFilter!.rangeValues != null) {
        filteredOrderList = filteredOrderList
            .where(
              (order) =>
                  order.totalAmount >= currentFilter!.rangeValues!.start &&
                  order.totalAmount <= currentFilter!.rangeValues!.end,
            )
            .toList();
      }
      if (currentFilter!.dateTimeRange != null) {
        filteredOrderList = filteredOrderList.where((order) {
          final createdAt = order.createdAt;
          final start = currentFilter!.dateTimeRange!.start;
          final end = currentFilter!.dateTimeRange!.end.add(Duration(days: 1));

          return createdAt.isAfter(start) && order.createdAt.isBefore(end) ||
              order.createdAt.isAtSameMomentAs(start) ||
              order.createdAt.isAtSameMomentAs(end);
        }).toList();
      }
    }
    return filteredOrderList;
  }

  Future<OrderFilter?> showOrdersFilterDialog(
    BuildContext context, [
    OrderFilter? previousFilter,
  ]) async => await showDialog(
    context: context,
    builder: (context) => OrdersFilterDialog(previousFilter: previousFilter),
  );
}
