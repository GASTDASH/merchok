import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/category/category.dart';
import 'package:merchok/generated/l10n.dart';

class CategoriesBottomSheet extends StatefulWidget {
  const CategoriesBottomSheet({super.key, this.selectedCategory});

  final Category? selectedCategory;

  @override
  State<CategoriesBottomSheet> createState() => _CategoriesBottomSheetState();
}

class _CategoriesBottomSheetState extends State<CategoriesBottomSheet> {
  @override
  void initState() {
    super.initState();

    context.read<CategoryBloc>().add(CategoryLoad());
  }

  @override
  Widget build(BuildContext context) {
    return BaseDraggableScrollableSheet(
      padding: EdgeInsets.zero,
      builder: (context, scrollController) => CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverToBoxAdapter(
              child: Row(
                spacing: 10,
                children: [
                  Expanded(child: SearchTextField()),
                  SizedBox(
                    height: 48,
                    width: 48,
                    child: BaseButton(
                      onTap: () async => await showAddCategoryDialog(context),
                      child: SvgPicture.asset(IconNames.add),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return LoadingBanner(message: state.message);
              } else if (state is CategoryLoaded) {
                if (state.categoryList.isNotEmpty) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverToBoxAdapter(
                      child: Wrap(
                        spacing: 10,
                        children: List.generate(state.categoryList.length, (
                          index,
                        ) {
                          final category = state.categoryList[index];
                          return CategoryChip(
                            category: category,
                            selected: category == widget.selectedCategory,
                            onSelected: (unselected) {
                              if (unselected) return context.pop(category);
                              return context.pop(Category.empty());
                            },
                            onLongPress: () async {
                              // if (!category.hasMerch) {
                              await showDeleteCategoryDialog(
                                context,
                                category.id,
                              );
                              // } else {
                              //   showDialog(
                              //     context: context,
                              //     builder: (context) => Dialog(
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(32),
                              //         child: Column(
                              //           spacing: 8,
                              //           mainAxisSize: MainAxisSize.min,
                              //           children: [
                              //             BaseSvgIcon(
                              //               context,
                              //               IconNames.delete,
                              //               height: 32,
                              //             ),
                              //             Text(
                              //               'Невозможно удалить используемую категорию',
                              //               style: Theme.of(
                              //                 context,
                              //               ).textTheme.titleMedium,
                              //               textAlign: TextAlign.center,
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   );
                              // }
                            },
                          );
                        }),
                      ),
                    ),
                  );
                }
                return InfoBanner(text: S.of(context).noCategories);
              } else if (state is CategoryError) {
                return ErrorBanner(message: state.error.toString());
              } else if (state is CategoryInitial) {
                return SliverFillRemaining();
              }
              return UnexpectedStateBanner();
            },
          ),
        ],
      ),
    );
  }

  Future<void> showAddCategoryDialog(BuildContext context) async {
    final bloc = context.read<CategoryBloc>();
    final s = S.of(context);

    String? name = await showAddDialog(context);
    if (name == null) return;
    if (name.isEmpty) name = s.untitled;

    bloc.add(CategoryAdd(name: name));
  }

  Future<void> showDeleteCategoryDialog(
    BuildContext context,
    String categoryId,
  ) async {
    return await showDeleteDialog(
      context: context,
      message: 'Удалить эту категорию?',
      onYes: () {
        context.pop();
        context.read<CategoryBloc>().add(
          CategoryDelete(categoryId: categoryId),
        );
      },
      onNo: () => context.pop(),
    );
  }
}

Future<Category?> showCategoriesBottomSheet(
  BuildContext context, [
  Category? selectedCategory,
]) => showBaseDraggableBottomSheet(
  context: context,
  builder: (context) =>
      CategoriesBottomSheet(selectedCategory: selectedCategory),
);
