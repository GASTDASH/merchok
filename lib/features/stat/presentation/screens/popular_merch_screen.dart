import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/stat/presentation/widgets/popular_merch_list.dart';
import 'package:merchok/generated/l10n.dart';

class PopularMerchScreen extends StatelessWidget {
  const PopularMerchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BaseSliverAppBar(title: S.of(context).popularMerch),
          SliverPadding(
            padding: EdgeInsets.all(24).copyWith(right: 36),
            sliver: Builder(
              builder: (context) {
                final orderState = context.watch<OrderBloc>().state;
                final merchState = context.watch<MerchBloc>().state;

                if (orderState is OrderLoaded && merchState is MerchLoaded) {
                  final List<Order> orderList = orderState.orderList;
                  final List<Merch> merchList = merchState.merchList;

                  return PopularMerchList(
                    orderList: orderList,
                    merchList: merchList,
                  );
                } else {
                  if (orderState is OrderLoading || merchState is MerchLoading)
                    return LoadingBanner();
                  if (orderState is OrderError || merchState is MerchError) {
                    return ErrorBanner(
                      message: orderState is OrderError
                          ? orderState.error.toString()
                          : (merchState as MerchError).error.toString(),
                    );
                  }
                  if (orderState is OrderInitial ||
                      merchState is MerchInitial) {
                    return SliverFillRemaining();
                  }
                  return UnexpectedStateBanner();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
