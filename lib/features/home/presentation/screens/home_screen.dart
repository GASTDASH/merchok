import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/category/categories.dart';
import 'package:merchok/features/home/home.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(child: SearchTextField()),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: Wrap(
                spacing: 10,
                runSpacing: 0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CategoryChip(
                    text: 'asdf',
                    selected: true,
                    onSelected: (value) {},
                  ),
                  CategoryChip(
                    text: '123124124',
                    selected: false,
                    onSelected: (value) {},
                  ),
                  CategoryChip(
                    text: '43434349',
                    selected: false,
                    onSelected: (value) {},
                  ),
                  CategoryChip(
                    text: '3434',
                    selected: false,
                    onSelected: (value) {},
                  ),
                  CategoryChip(
                    text: '34343434',
                    selected: false,
                    onSelected: (value) {},
                  ),
                  CategoryChip(
                    text: '123123123',
                    selected: false,
                    onSelected: (value) {},
                  ),
                  CategoryChip(
                    text: 'asdf',
                    selected: false,
                    onSelected: (value) {},
                  ),
                  BaseButton(
                    onTap: () {
                      showCategoriesBottomSheet(context);
                    },
                    constraints: BoxConstraints(minWidth: 72, maxWidth: 72),
                    child: Text(
                      S.of(context).all,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList.builder(
              itemCount: 1,
              itemBuilder: (context, index) => MerchCard(count: 0),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 20,
                children: [
                  AddButton(text: S.of(context).add, icon: IconNames.add),
                  AddButton(
                    onTap: () {
                      showImportBottomSheet(context);
                    },
                    text: S.of(context).import,
                    icon: IconNames.import,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
