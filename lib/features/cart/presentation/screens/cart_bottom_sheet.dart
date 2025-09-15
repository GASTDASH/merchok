import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/cart/cart.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/payment_method/payment_method.dart';
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
    context.read<PaymentMethodBloc>().add(PaymentMethodLoad());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrentPaymentMethodCubit(),
      child: BaseDraggableScrollableSheet(
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
                    return _CartContent(cartItems: state.cartItems);
                  } else {
                    return _EmptyCart();
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
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InfoBanner.icon(text: S.of(context).emptyCart, icon: IconNames.cart);
  }
}

class _CartContent extends StatelessWidget {
  const _CartContent({required this.cartItems});

  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(24),
      sliver: SliverMainAxisGroup(
        slivers: [
          _CartTotal(cartItems: cartItems),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          _PaymentMethodSection(),
          SliverToBoxAdapter(child: SizedBox(height: 24)),
          _CartItemsList(cartItems: cartItems),
        ],
      ),
    );
  }
}

class _CartItemsList extends StatelessWidget {
  const _CartItemsList({required this.cartItems});

  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final merchState = context.read<MerchBloc>().state;
        if (merchState is! MerchLoaded) {
          return InfoBanner(text: S.of(context).merchListNotLoaded);
        }

        return SliverList.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, i) {
            final cartItem = cartItems[i];
            final merch = merchState.merchList.firstWhere(
              (merch) => merch.id == cartItem.merchId,
            );

            return MerchCard(
              merch: merch,
              count: cartItem.quantity,
              editable: false,
              onTapDelete: () {
                context.read<CartBloc>().add(CartDelete(merchId: merch.id));
              },
            );
          },
        );
      },
    );
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({required this.cartItems});

  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).total,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          _TotalPrice(cartItems: cartItems),
        ],
      ),
    );
  }
}

class _TotalPrice extends StatelessWidget {
  const _TotalPrice({required this.cartItems});

  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final merchState = context.read<MerchBloc>().state;

    if (merchState is MerchLoaded) {
      final sum = sumCartItems(cartItems, merchState.merchList);
      return Text(
        '${sum.truncateIfInt()} ₽',
        style: theme.textTheme.headlineLarge,
      );
    } else {
      return Text(S.of(context).merchIsNotLoaded);
    }
  }

  double sumCartItems(List<CartItem> cartItems, List<Merch> merchList) {
    return cartItems.fold<double>(0, (sum, cartItem) {
      final merch = merchList.firstWhere((m) => m.id == cartItem.merchId);
      return sum + merch.price * cartItem.quantity;
    });
  }
}

class _PaymentMethodSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverMainAxisGroup(
      slivers: [
        // Text
        SliverToBoxAdapter(
          child: Text(
            '${S.of(context).paymentMethod}:',
            style: theme.textTheme.bodyLarge,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 8)),
        // DropdownMenu
        BlocBuilder<CurrentPaymentMethodCubit, PaymentMethod?>(
          builder: (context, selectedPaymentMethod) {
            return SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
                    builder: (context, state) {
                      if (state is PaymentMethodLoading) {
                        return LoadingIndicator();
                      } else if (state is PaymentMethodLoaded) {
                        if (state.paymentMethodList.isNotEmpty) {
                          return PaymentMethodDropdownMenu(
                            paymentMethodList: state.paymentMethodList,
                            selectedPaymentMethod: selectedPaymentMethod,
                            onSelected: (paymentMethod) => context
                                .read<CurrentPaymentMethodCubit>()
                                .selectPaymentMethod(paymentMethod),
                          );
                        }
                        return Text(S.of(context).noPaymentMethods);
                      } else if (state is PaymentMethodError) {
                        return Text(S.of(context).errorLoadingPaymentMethods);
                      }
                      return Text(S.of(context).paymentMethodsNotLoaded);
                    },
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(
                  child: _CheckoutButton(
                    enabled: selectedPaymentMethod != null,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _CheckoutButton extends StatelessWidget {
  const _CheckoutButton({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onTap: enabled
          ? () {
              context.pop();
              showDialog(
                context: context,
                builder: (context) => OrderCreatedDialog(),
              );
            }
          : null,
      padding: EdgeInsetsGeometry.all(12),
      child: Text(
        S.of(context).checkout,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
