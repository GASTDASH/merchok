import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/generated/l10n.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
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
                    children: [
                      BaseButton.outlined(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => OrdersFilterDialog(),
                          );
                        },
                        color: theme.colorScheme.onSurface,
                        child: Row(
                          spacing: 8,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(S.of(context).filter),
                            SvgPicture.asset(
                              IconNames.filter,
                              colorFilter: ColorFilter.mode(
                                theme.colorScheme.onSurface,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
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
                        return SliverList.separated(
                          itemCount: state.orderList.length,
                          separatorBuilder: (context, index) =>
                              Divider(indent: 32, endIndent: 32, height: 48),
                          itemBuilder: (context, index) =>
                              ReceiptWidget(order: state.orderList[index]),
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
}
