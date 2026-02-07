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

class _OrdersScreenState extends State<OrdersScreen>
    with SaveScrollPositionMixin {
  @override
  void initState() {
    super.initState();

    context.read<OrderBloc>().add(OrderLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(24).copyWith(top: 16),
            sliver: BlocConsumer<OrderBloc, OrderState>(
              listener: (context, state) {
                if (state is OrderLoaded) restoreScrollPosition();
              },
              listenWhen: (previous, current) {
                if (current is OrderLoading && previous is OrderLoaded) {
                  saveScrollPosition();
                }
                return true;
              },
              builder: (context, state) {
                if (state is OrderLoading) {
                  return LoadingBanner(message: state.message);
                } else if (state is OrderLoaded) {
                  if (state.orderList.isNotEmpty) {
                    return _OrderList(orderList: state.orderList);
                  } else {
                    return InfoBanner(text: S.of(context).noReceipts);
                  }
                } else if (state is OrderError) {
                  return ErrorBanner(message: state.error.toString());
                } else if (state is OrderInitial) {
                  return const SliverFillRemaining(hasScrollBody: false);
                }
                return const UnexpectedStateBanner();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderList extends StatefulWidget {
  const _OrderList({required this.orderList});

  final List<Order> orderList;

  @override
  State<_OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<_OrderList> {
  OrderFilter? currentFilter;
  final OrderSortingProvider orderSortingProvider = OrderSortingProvider();

  void sortOrderList(List<Order> orderList) {
    switch (orderSortingProvider.orderSorting.sortBy) {
      case OrderSortBy.createdAt:
        orderList.sort(
          (a, b) => sortOrdering(a.createdAt.compareTo(b.createdAt)),
        );
        break;
      case OrderSortBy.totalAmount:
        orderList.sort(
          (a, b) => sortOrdering(a.totalEarned.compareTo(b.totalEarned)),
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
                  order.totalEarned >= currentFilter!.rangeValues!.start &&
                  order.totalEarned <= currentFilter!.rangeValues!.end,
            )
            .toList();
      }
      if (currentFilter!.dateTimeRange != null) {
        final start = currentFilter!.dateTimeRange!.start;
        final end = currentFilter!.dateTimeRange!.end.add(
          const Duration(days: 1),
        );

        filteredOrderList = filteredOrderList.where((order) {
          final createdAt = order.createdAt;
          return createdAt.isAfter(start) && order.createdAt.isBefore(end) ||
              order.createdAt.isAtSameMomentAs(start) ||
              order.createdAt.isAtSameMomentAs(end);
        }).toList();
      }
      if (currentFilter!.festival != null) {
        filteredOrderList = filteredOrderList
            .where((order) => order.festival == currentFilter!.festival)
            .toList();
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
    return ListenableBuilder(
      listenable: orderSortingProvider,
      builder: (context, _) {
        final List<Order> filteredOrderList = filterOrderList(widget.orderList);
        sortOrderList(filteredOrderList);

        return SliverMainAxisGroup(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                spacing: 12,
                children: [
                  FilterButton(
                    onTap: () async {
                      double maxAmount = 0;
                      for (Order order in widget.orderList) {
                        if (maxAmount < order.totalEarned) {
                          maxAmount = order.totalEarned;
                        }
                      }

                      final filter = await showOrdersFilterDialog(
                        context,
                        maxAmount,
                        currentFilter,
                      );
                      if (filter == null) return;
                      if (filter.isEmpty) {
                        return setState(() => currentFilter = null);
                      }
                      setState(() => currentFilter = filter);
                    },
                    active: currentFilter != null,
                  ),
                  SortButton(
                    onTap: () => orderSortingProvider.changeOrderSorting(),
                    icons: [
                      orderSortingProvider.orderSorting.sortBy.icon,
                      orderSortingProvider.orderSorting.sortOrder.icon,
                    ],
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            filteredOrderList.isEmpty && currentFilter != null
                ? InfoBanner(text: S.of(context).noMatchingOrders)
                : SliverList.separated(
                    itemCount: filteredOrderList.length,
                    separatorBuilder: (context, index) =>
                        const Divider(indent: 32, endIndent: 32, height: 48),
                    itemBuilder: (context, index) =>
                        ReceiptWidget(order: filteredOrderList[index]),
                  ),
          ],
        );
      },
    );
  }
}
