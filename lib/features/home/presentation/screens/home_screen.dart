import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/cart/cart.dart';
import 'package:merchok/features/category/category.dart';
import 'package:merchok/features/current_category/current_category.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/home/home.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SaveScrollPositionMixin {
  final MerchSortingProvider merchSortingProvider = MerchSortingProvider();
  final TextEditingController searchController = TextEditingController();
  final ListController listController = ListController();

  @override
  void dispose() {
    searchController.dispose();
    merchSortingProvider.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    context.read<FestivalBloc>().add(FestivalLoad());
    context.read<CategoryBloc>().add(CategoryLoad());
    context.read<MerchBloc>().add(MerchLoad());
    context.read<CartBloc>().add(CartLoad());
  }

  Future<String?> scan(BuildContext context) async =>
      await context.push<String?>('/scan');

  Future<void> showScannedMerchNotFoundDialog(BuildContext context) async =>
      await showDialog(
        context: context,
        builder: (context) => const NotFoundDialog(),
      );

  void sortMerchList(List<Merch> merchList) {
    switch (merchSortingProvider.merchSorting.sortBy) {
      case MerchSortBy.alphabet:
        merchList.sort((a, b) => sortOrdering(a.name.compareTo(b.name)));
        break;
      // case MerchSortBy.createdAt:
      //   merchList.sort((a, b) => sortOrdering(a.compareTo(b.name)));
      //   break;
      default:
        break;
    }
  }

  int sortOrdering(int comparison) {
    return merchSortingProvider.merchSorting.sortOrder == SortOrder.asc
        ? comparison
        : -comparison;
  }

  List<Merch> filterMerchList(
    List<Merch> merchList,
    Category? selectedCategory,
  ) {
    {
      // Если поле поиска не пустое
      if (searchController.text.isNotEmpty) {
        merchList = filterBySearch(merchList);
      }

      // Если выбрана категория
      if (selectedCategory != null) {
        merchList = filterByCategory(merchList, selectedCategory);
      }
    }
    return merchList;
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrentCategoryCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              controller: scrollController,
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                BlocBuilder<MerchBloc, MerchState>(
                  builder: (context, state) {
                    if (state is MerchLoaded && state.merchList.isNotEmpty) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        sliver: SliverToBoxAdapter(
                          child: SearchTextField(controller: searchController),
                        ),
                      );
                    } else {
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    }
                  },
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverPadding(
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: 24),
                  sliver: SliverToBoxAdapter(child: _CategoriesWrap()),
                ),
                ListenableBuilder(
                  listenable: Listenable.merge([
                    merchSortingProvider,
                    searchController,
                  ]),
                  builder: (context, _) => BlocConsumer<MerchBloc, MerchState>(
                    listener: (context, state) {
                      if (state is MerchLoaded) restoreScrollPosition();
                    },
                    listenWhen: (previous, current) {
                      if (current is MerchLoading && previous is MerchLoaded) {
                        saveScrollPosition();
                      }
                      return true;
                    },
                    builder: (context, state) {
                      if (state is MerchLoading) {
                        return LoadingBanner(message: state.message);
                      } else if (state is MerchLoaded) {
                        if (state.merchList.isNotEmpty) {
                          final cartState = context.watch<CartBloc>().state;
                          final selectedCategory = context
                              .watch<CurrentCategoryCubit>()
                              .state;

                          List<Merch> merchList = filterMerchList(
                            state.merchList,
                            selectedCategory,
                          );

                          sortMerchList(merchList);

                          // Если пустой список при какой-то фильтрации
                          if (merchList.isEmpty &&
                              (searchController.text.isNotEmpty ||
                                  selectedCategory != null)) {
                            return InfoBanner(
                              text: S.of(context).noMatchingMerch,
                            );
                          }
                          return SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            sliver: SliverMainAxisGroup(
                              slivers: [
                                _SortRow(
                                  merchSortingProvider: merchSortingProvider,
                                ),
                                _MerchList(
                                  merchList: merchList,
                                  cartItems: [
                                    if (cartState is CartLoaded &&
                                        cartState.cartItems.isNotEmpty)
                                      ...cartState.cartItems,
                                  ],
                                  scrollController: scrollController,
                                  listController: listController,
                                ),
                                SliverPadding(
                                  padding: const EdgeInsets.only(
                                    top: 12,
                                    bottom: 128,
                                  ),
                                  sliver: SliverToBoxAdapter(
                                    child: _AddButtons(),
                                  ),
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
                        return const SliverFillRemaining();
                      }
                      return const UnexpectedStateBanner();
                    },
                  ),
                ),
              ],
            ),
            BlocBuilder<MerchBloc, MerchState>(
              builder: (context, state) {
                if (state is MerchLoaded && state.merchList.isNotEmpty) {
                  return Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        height: 64,
                        width: 64,
                        child: FloatingActionButton(
                          heroTag: const ValueKey('scan'),
                          onPressed: () async {
                            final currentCategoryCubit = context
                                .read<CurrentCategoryCubit>();

                            final String? id = await scan(context);
                            if (id == null) return;

                            final merchIndex = state.merchList.indexWhere(
                              (merch) => merch.id == id,
                            );
                            if (merchIndex == -1) {
                              if (!context.mounted) return;
                              return showScannedMerchNotFoundDialog(context);
                            }

                            if (searchController.text.isNotEmpty ||
                                currentCategoryCubit.state != null) {
                              searchController.clear();
                              currentCategoryCubit.clearCategory();

                              await Future.delayed(
                                const Duration(milliseconds: 300),
                              );
                            }

                            listController.animateToItem(
                              index: merchIndex,
                              scrollController: scrollController,
                              duration: (estimatedDistance) =>
                                  const Duration(milliseconds: 500),
                              curve: (estimatedDistance) => Curves.easeOutQuart,
                              alignment: 0.5,
                              rect: merchIndex == state.merchList.length - 1
                                  ? const Rect.fromLTRB(0, 0, 0, 100)
                                  : null,
                            );
                          },
                          shape: const CircleBorder(),
                          backgroundColor: Colors.white,
                          child: const Icon(
                            Icons.qr_code_scanner_rounded,
                            size: 32,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SortRow extends StatelessWidget {
  const _SortRow({required this.merchSortingProvider});

  final MerchSortingProvider merchSortingProvider;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          SortButton(
            onTap: () => merchSortingProvider.changeMerchSorting(),
            icons: [
              merchSortingProvider.merchSorting.sortBy.icon,
              merchSortingProvider.merchSorting.sortOrder.icon,
            ],
          ),
        ],
      ),
    );
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
              const LoadingIndicator(),
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
                      constraints: const BoxConstraints(
                        minWidth: 72,
                        maxWidth: 72,
                      ),
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
                const SizedBox(height: 12),
              ],
            );
          }
          return const SizedBox.shrink();
        } else if (state is CategoryError) {
          return Row(
            spacing: 8,
            children: [
              Text(S.of(context).loadingError),
              const Icon(Icons.warning_outlined),
            ],
          );
        } else if (state is CategoryInitial) {
          return const SizedBox.shrink();
        }
        return const SizedBox.shrink();
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
          const SizedBox(height: 24),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _AddButtons(),
              ),
            ),
          ),
          const SizedBox(height: 128),
        ],
      ),
    );
  }
}

class _AddButtons extends StatelessWidget {
  Future<void> showImportBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (context) => const ImportBottomSheet(),
    );
  }

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
          icon: AppIcons.add,
        ),
        AddButton(
          onTap: () {
            showImportBottomSheet(context);
          },
          text: S.of(context).import,
          icon: AppIcons.import,
        ),
      ],
    );
  }
}

class _MerchList extends StatelessWidget {
  const _MerchList({
    required this.merchList,
    required this.cartItems,
    required this.scrollController,
    required this.listController,
  });

  final List<CartItem> cartItems;
  final List<Merch> merchList;
  final ScrollController scrollController;
  final ListController listController;

  Future<void> showDeleteMerchDialog(
    BuildContext context,
    String merchId,
  ) async => await showYesNoDialog(
    context: context,
    message: S.of(context).deleteThisMerch,
    onYes: () {
      context.pop();
      context.read<MerchBloc>().add(MerchDelete(merchId: merchId));
    },
    onNo: () => context.pop(),
  );

  Future<void> showUnableToDeleteMerchDialog(BuildContext context) async {
    final theme = Theme.of(context);
    return await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(AppIcons.delete, size: 32),
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

  @override
  Widget build(BuildContext context) {
    return SuperSliverList.builder(
      listController: listController,
      itemCount: merchList.length,
      itemBuilder: (context, index) {
        final merch = merchList[index];

        return BlocSelector<CartBloc, CartState, int?>(
          selector: (state) {
            if (state is CartLoaded) {
              return state.cartItems
                  .firstWhereOrNull((item) => item.merchId == merch.id)
                  ?.quantity;
            }
            return 0;
          },
          builder: (context, quantity) {
            return MerchCard(
              onLongPress: quantity == null
                  ? () => showDeleteMerchDialog(context, merch.id)
                  : () => showUnableToDeleteMerchDialog(context),
              merch: merch,
              count: quantity ?? 0,
            );
          },
        );
      },
    );
  }
}
