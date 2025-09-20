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

  void sortOrderList(List<Order> orderList) {
    switch (orderSortingProvider.orderSorting.sortBy) {
      case OrderSortBy.createdAt:
        orderList.sort(
          (a, b) => sortOrdering(a.createdAt.compareTo(b.createdAt)),
        );
        break;
      case OrderSortBy.totalAmount:
        orderList.sort(
          (a, b) => sortOrdering(a.totalAmount.compareTo(b.totalAmount)),
        );
        break;
    }
  }

  int sortOrdering(int comparison) {
    return orderSortingProvider.orderSorting.sortOrder == SortOrder.desc
        ? comparison
        : -comparison;
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
        final start = currentFilter!.dateTimeRange!.start;
        final end = currentFilter!.dateTimeRange!.end.add(Duration(days: 1));

        filteredOrderList = filteredOrderList.where((order) {
          final createdAt = order.createdAt;
          return createdAt.isAfter(start) && order.createdAt.isBefore(end) ||
              order.createdAt.isAtSameMomentAs(start) ||
              order.createdAt.isAtSameMomentAs(end);
        }).toList();
      }
    }
    return filteredOrderList;
  }

  Future<OrderFilter?> showOrdersFilterDialog(
    BuildContext context,
    double maxAmount, [
    OrderFilter? previousFilter,
  ]) async {
    return await showDialog(
      context: context,
      builder: (context) => OrdersFilterDialog(
        previousFilter: previousFilter,
        maxAmount: maxAmount,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(24).copyWith(top: 16),
            sliver: ListenableBuilder(
              listenable: orderSortingProvider,
              builder: (context, _) {
                return BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    if (state is OrderLoading) {
                      return LoadingBanner(message: state.message);
                    } else if (state is OrderLoaded) {
                      if (state.orderList.isNotEmpty) {
                        List<Order> orderList = filterOrderList(
                          state.orderList,
                        );

                        sortOrderList(orderList);

                        if (orderList.isEmpty && currentFilter != null) {
                          return InfoBanner(
                            text: S.of(context).noMatchingOrders,
                          );
                        }
                        return SliverMainAxisGroup(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Row(
                                spacing: 12,
                                children: [
                                  BaseButton.outlined(
                                    onTap: () async {
                                      double maxAmount = 0;
                                      for (Order order in state.orderList) {
                                        if (maxAmount < order.totalAmount) {
                                          maxAmount = order.totalAmount;
                                        }
                                      }

                                      final filter =
                                          await showOrdersFilterDialog(
                                            context,
                                            maxAmount,
                                            currentFilter,
                                          );
                                      if (filter == null) return;
                                      if (filter.isEmpty) {
                                        return setState(
                                          () => currentFilter = null,
                                        );
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
                                  BaseButton.outlined(
                                    onTap: () => orderSortingProvider
                                        .changeOrderSorting(),
                                    color: theme.colorScheme.onSurface,
                                    child: Row(
                                      spacing: 8,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(S.of(context).sorting),
                                        BaseSvgIcon(
                                          context,
                                          orderSortingProvider
                                              .orderSorting
                                              .sortBy
                                              .icon,
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
                                  ),
                                ],
                              ),
                            ),
                            SliverToBoxAdapter(child: SizedBox(height: 16)),
                            SliverList.separated(
                              itemCount: orderList.length,
                              separatorBuilder: (context, index) => Divider(
                                indent: 32,
                                endIndent: 32,
                                height: 48,
                              ),
                              itemBuilder: (context, index) =>
                                  ReceiptWidget(order: orderList[index]),
                            ),
                          ],
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
