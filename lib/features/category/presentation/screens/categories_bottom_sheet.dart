import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/category/categories.dart';

class CategoriesBottomSheet extends StatelessWidget {
  const CategoriesBottomSheet({super.key});

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
                      onTap: () {
                        showAddDialog(context);
                      },
                      child: SvgPicture.asset(IconNames.add),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: Wrap(
                spacing: 10,
                children: List.generate(
                  20,
                  (index) => CategoryChip(
                    text: 'text${index * index * index * index}',
                    selected: false,
                    onSelected: (value) {},
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> showCategoriesBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => CategoriesBottomSheet(),
  );
}
