import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/cart/cart.dart';
import 'package:merchok/features/category/category.dart';
import 'package:merchok/features/current_category/current_category.dart';
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

    context.read<CategoryBloc>().add(CategoryLoad());
    context.read<MerchBloc>().add(MerchLoad());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrentCategoryCubit(),
      child: Scaffold(
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
            BlocBuilder<MerchBloc, MerchState>(
              builder: (context, state) {
                if (state is MerchLoading) {
                  return LoadingBanner(message: state.message);
                } else if (state is MerchLoaded) {
                  if (state.merchList.isNotEmpty) {
                    final cartState = context.watch<CartBloc>().state;
                    final selectedCategory = context
                        .watch<CurrentCategoryCubit>()
                        .state;
                    List<Merch> merchList = state.merchList;

                    // Если поле поиска не пустое
                    if (searchController.text.isNotEmpty) {
                      merchList = filterBySearch(merchList);
                    }

                    // Если выбрана категория
                    if (selectedCategory != null) {
                      merchList = filterByCategory(merchList, selectedCategory);
                    }

                    // Если пустой список при какой-то фильтрации
                    if (merchList.isEmpty &&
                        (searchController.text.isNotEmpty ||
                            selectedCategory != null)) {
                      return InfoBanner(text: S.of(context).noMatchingMerch);
                    }
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      sliver: SliverMainAxisGroup(
                        slivers: [
                          _MerchList(
                            merchList: merchList,
                            cartItems: [
                              if (cartState is CartLoaded &&
                                  cartState.cartItems.isNotEmpty)
                                ...cartState.cartItems,
                            ],
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              bottom: 128,
                            ),
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
      ),
    );
  }

  List<Merch> filterByCategory(
    List<Merch> merchList,
    Category selectedCategory,
  ) {
    merchList = merchList
        .where((merch) => merch.categoryId == selectedCategory.id)
        .toList();
    return merchList;
  }

  List<Merch> filterBySearch(List<Merch> filteredMerchList) {
    filteredMerchList = filteredMerchList
        .where((merch) => merch.name.contains(searchController.text))
        .toList();
    return filteredMerchList;
  }
}

class _CategoriesWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return Row(
            spacing: 8,
            children: [
              if (state.message != null) Text(state.message!),
              LoadingIndicator(),
            ],
          );
        } else if (state is CategoryLoaded) {
          if (state.categoryList.isNotEmpty) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 0,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ...List.generate(state.categoryList.length.clamp(0, 10), (
                      i,
                    ) {
                      final category = state.categoryList[i];
                      final cubit = context.watch<CurrentCategoryCubit>();

                      return CategoryChip(
                        category: category,
                        selected: category == cubit.state,
                        onSelected: (unselected) {
                          if (unselected) return cubit.selectCategory(category);
                          return cubit.clearCategory();
                        },
                      );
                    }),
                    BaseButton(
                      onTap: () async {
                        final cubit = context.read<CurrentCategoryCubit>();
                        final category = await showCategoriesBottomSheet(
                          context,
                          cubit.state,
                        );
                        if (category == null) return;
                        if (category.isEmpty) return cubit.clearCategory();
                        cubit.selectCategory(category);
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
                ),
                SizedBox(height: 12),
              ],
            );
          }
          return SizedBox.shrink();
        } else if (state is CategoryError) {
          return Row(
            spacing: 8,
            children: [
              Text(S.of(context).loadingError),
              Icon(Icons.warning_outlined),
            ],
          );
        } else if (state is CategoryInitial) {
          return SizedBox.shrink();
        }
        return SizedBox.shrink();
      },
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
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _AddButtons(),
              ),
            ),
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
