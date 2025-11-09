import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/stock/stock.dart';

class SelectMerchBottomSheet extends StatelessWidget {
  const SelectMerchBottomSheet({super.key, required this.merchList});

  final List<Merch> merchList;

  @override
  Widget build(BuildContext context) {
    return BaseDraggableScrollableSheet(
      builder: (context, scrollController) => CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverList.separated(
            itemCount: merchList.length,
            itemBuilder: (context, index) {
              final merch = merchList[index];
              return MerchStockListTile(
                merch: merch,
                onTap: () => context.pop(merch),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          ),
        ],
      ),
    );
  }
}
