import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/cart/cart.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/generated/l10n.dart';

class CartBottomSheet extends StatefulWidget {
  const CartBottomSheet({super.key});

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  @override
  void initState() {
    super.initState();

    context.read<CartBloc>().add(CartLoad());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseDraggableScrollableSheet(
      padding: EdgeInsets.zero,
      builder: (context, scrollController) => CustomScrollView(
        controller: scrollController,
        slivers: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return LoadingBanner(message: state.message);
              } else if (state is CartLoaded) {
                if (state.cartItems.isNotEmpty) {
                  return SliverPadding(
                    padding: const EdgeInsets.all(24),
                    sliver: SliverMainAxisGroup(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).total,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Builder(
                                builder: (context) {
                                  final merchState = context
                                      .read<MerchBloc>()
                                      .state;
                                  if (merchState is MerchLoaded) {
                                    final sum = sumCartItems(
                                      state.cartItems,
                                      merchState.merchList,
                                    );
                                    return Text(
                                      '${sum.truncateIfInt()} ₽',
                                      style: theme.textTheme.headlineLarge,
                                    );
                                  } else {
                                    return Text(S.of(context).merchIsNotLoaded);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 12)),
                        SliverToBoxAdapter(
                          child: Text(
                            '${S.of(context).paymentMethod}:',
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 8)),
                        SliverToBoxAdapter(
                          child: DropdownMenu(
                            width: double.infinity,
                            leadingIcon: Padding(
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                IconNames.sberbank,
                                height: 32,
                              ),
                            ),
                            inputDecorationTheme: InputDecorationTheme(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onSelected: (value) {},
                            initialSelection: 'paymentMethodN',
                            dropdownMenuEntries: [
                              DropdownMenuEntry(
                                leadingIcon: SvgPicture.asset(
                                  IconNames.money,
                                  height: 32,
                                ),
                                value: 'paymentMethodN',
                                label: 'Наличка',
                              ),
                              ...List.generate(
                                5,
                                (index) => DropdownMenuEntry(
                                  leadingIcon: SvgPicture.asset(
                                    IconNames.sberbank,
                                    height: 32,
                                  ),
                                  value: 'paymentMethod${++index}',
                                  label: 'Способ оплаты $index',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 24)),
                        SliverToBoxAdapter(
                          child: BaseButton(
                            onTap: () {
                              context.pop();
                              showDialog(
                                context: context,
                                builder: (context) => OrderCreatedDialog(),
                              );
                            },
                            padding: EdgeInsetsGeometry.all(12),
                            child: Text(
                              S.of(context).checkout,
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 24)),
                        Builder(
                          builder: (context) {
                            final merchState = context.read<MerchBloc>().state;
                            if (merchState is! MerchLoaded) {
                              return InfoBanner(
                                text: S.of(context).merchListNotLoaded,
                              );
                            }

                            return SliverList.builder(
                              itemCount: state.cartItems.length,
                              itemBuilder: (context, index) {
                                final cartItem = state.cartItems[index];
                                final merch = merchState.merchList.firstWhere(
                                  (merch) => merch.id == cartItem.merchId,
                                );

                                return MerchCard(
                                  merch: merch,
                                  count: cartItem.quantity,
                                  editable: false,
                                  onTapDelete: () => context
                                      .read<CartBloc>()
                                      .add(CartDelete(merchId: merch.id)),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return InfoBanner.icon(
                    text: S.of(context).emptyCart,
                    icon: IconNames.cart,
                  );
                }
              } else if (state is CartError) {
                return ErrorBanner(message: state.error.toString());
              } else if (state is CartInitial) {
                return SliverFillRemaining();
              }
              return UnexpectedStateBanner();
            },
          ),
        ],
      ),
    );
  }

  double sumCartItems(List<CartItem> cartItems, List<Merch> merchList) {
    return cartItems.fold<double>(0, (sum, cartItem) {
      final merch = merchList.firstWhere((m) => m.id == cartItem.merchId);
      return sum + merch.price * cartItem.quantity;
    });
  }
}
