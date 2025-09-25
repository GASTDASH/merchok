import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/generated/l10n.dart';

class PopularMerchList extends StatelessWidget {
  const PopularMerchList({
    super.key,
    required this.orderList,
    required this.merchList,
  });

  final List<Merch> merchList;
  final List<Order> orderList;

  Map<Merch, int> _countMerch(List<Merch> merchList, List<Order> orderList) {
    final Set<Merch> merchListFromOrders = orderList
        .expand((order) => order.orderItems.map((item) => item.merch))
        .toSet();
    log('[_countMerch] merchListFromOrders is ready');

    final List<Merch> uniqueMerchList = {
      ...merchListFromOrders,
      ...merchList,
    }.toList();
    log('[_countMerch] uniqueMerchList is ready');

    final Map<Merch, int> merchesCount = {};

    for (Merch merch in uniqueMerchList) {
      int count = 0;
      for (Order order in orderList) {
        count += order.orderItems
            .where((item) => item.merch == merch)
            .fold(0, (sum, item) => sum + item.quantity);
      }
      merchesCount.addAll({merch: count});
    }
    log('[_countMerch] merchesCount is ready');

    final Map<Merch, int> sortedMerchesCount = Map.fromEntries(
      merchesCount.entries.sorted((a, b) => b.value.compareTo(a.value)),
    );
    log('[_countMerch] sortedMerchesCount is ready');

    return sortedMerchesCount;
  }

  Future<Map<Merch, int>> _compute() async {
    return await compute((_) => _countMerch(merchList, orderList), null);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _compute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingBanner(message: S.of(context).loading);
        }
        if (snapshot.hasError) {
          return ErrorBanner(message: snapshot.error.toString());
        }
        if (snapshot.hasData) {
          return SliverList.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, i) => _PopularMerchItem(
              index: i,
              merchCount: snapshot.data!.entries.elementAt(i),
            ),
          );
        } else {
          return InfoBanner(text: S.of(context).noDataToDisplay);
        }
      },
    );
  }
}

class _PopularMerchItem extends StatelessWidget {
  const _PopularMerchItem({required this.index, required this.merchCount});

  final int index;
  final MapEntry<Merch, int> merchCount;

  Widget buildMedalWidget() {
    return switch (index) {
      0 => Text(
        '🥇', // translate-me-ignore
        style: TextStyle(fontSize: 32),
      ),
      1 => Text(
        '🥈', // translate-me-ignore
        style: TextStyle(fontSize: 32),
      ),
      2 => Text(
        '🥉', // translate-me-ignore
        style: TextStyle(fontSize: 32),
      ),
      int() => SizedBox(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 48,
            child: Row(
              spacing: 8,
              children: [
                SizedBox(width: 48, child: buildMedalWidget()),
                Text(merchCount.key.name, style: theme.textTheme.titleMedium),
              ],
            ),
          ),
          Text('${merchCount.value}', style: theme.textTheme.titleLarge),
        ],
      ),
    );
  }
}
