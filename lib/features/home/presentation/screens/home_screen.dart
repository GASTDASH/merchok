import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/cart/cart.dart';
import 'package:merchok/features/category/categories.dart';
import 'package:merchok/features/home/home.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<MerchBloc>().add(MerchLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: SearchTextField(
                controller: searchController,
                onChanged: (_) => setState(() {}),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(child: _CategoriesWrap()),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          BlocBuilder<MerchBloc, MerchState>(
            builder: (context, state) {
              final cartState = context.watch<CartBloc>().state;

              if (state is MerchLoading) {
                return LoadingBanner(message: state.message);
              } else if (state is MerchLoaded) {
                if (state.merchList.isNotEmpty) {
                  final filteredMerchList = searchController.text.isNotEmpty
                      ? state.merchList
                            .where(
                              (merch) =>
                                  merch.name.contains(searchController.text),
                            )
                            .toList()
                      : state.merchList;

                  if (filteredMerchList.isEmpty) {
                    return InfoBanner(text: S.of(context).noMatchingMerch);
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverMainAxisGroup(
                      slivers: [
                        _MerchList(
                          merchList: filteredMerchList,
                          cartItems: [
                            if (cartState is CartLoaded &&
                                cartState.cartItems.isNotEmpty)
                              ...cartState.cartItems,
                          ],
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.only(top: 12, bottom: 128),
                          sliver: SliverToBoxAdapter(child: _AddButtons()),
                        ),
                      ],
                    ),
                  );
                } else {
                  return _NoMerchBanner();
                }
              } else if (state is MerchError) {
                return ErrorBanner(message: state.error.toString());
              } else if (state is MerchInitial) {
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

class _CategoriesWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        CategoryChip(
          text: S.of(context).temporaryUnavailable,
          selected: true,
          onSelected: (value) {},
        ),
        BaseButton(
          onTap: () {
            showCategoriesBottomSheet(context);
          },
          constraints: BoxConstraints(minWidth: 72, maxWidth: 72),
          child: Text(
            S.of(context).all,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _NoMerchBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  S.of(context).noMerch,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: Align(alignment: Alignment.topCenter, child: _AddButtons()),
          ),
          SizedBox(height: 128),
        ],
      ),
    );
  }
}

class _AddButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      runSpacing: 20,
      children: [
        AddButton(
          onTap: () {
            context.read<MerchBloc>().add(MerchAdd());
          },
          text: S.of(context).add,
          icon: IconNames.add,
        ),
        AddButton(
          onTap: () {
            showImportBottomSheet(context);
          },
          text: S.of(context).import,
          icon: IconNames.import,
        ),
      ],
    );
  }

  Future<dynamic> showImportBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (context) => ImportBottomSheet(),
    );
  }
}

class _MerchList extends StatelessWidget {
  const _MerchList({required this.merchList, required this.cartItems});

  final List<Merch> merchList;
  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartBloc, CartState, Map<String, int>>(
      selector: (state) => Map.fromEntries(
        cartItems.map(
          (cartItem) => MapEntry(cartItem.merchId, cartItem.quantity),
        ),
      ),
      builder: (context, cartItemQuantities) {
        return SliverList.builder(
          itemCount: merchList.length,
          itemBuilder: (context, index) {
            final merch = merchList[index];

            return MerchCard(
              onLongPress: cartItemQuantities[merch.id] == null
                  ? () => showDeleteMerchDialog(context, merch.id)
                  : () => showUnableToDeleteMerchDialog(context),
              merch: merch,
              count: cartItemQuantities[merch.id] ?? 0,
            );
          },
        );
      },
    );
  }

  Future<dynamic> showDeleteMerchDialog(
    BuildContext context,
    String merchId,
  ) async => await showDeleteDialog(
    context: context,
    message: S.of(context).deleteThisMerch,
    onYes: () {
      context.pop();
      context.read<MerchBloc>().add(MerchDelete(merchId: merchId));
    },
    onNo: () => context.pop(),
  );

  Future<dynamic> showUnableToDeleteMerchDialog(BuildContext context) async {
    final theme = Theme.of(context);
    return await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseSvgIcon(context, IconNames.delete, height: 32),
              Text(
                S.of(context).unableToDeleteMerch,
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
