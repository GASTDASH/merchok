import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';
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
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 48,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.hintColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).search,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                    SvgPicture.asset(
                      IconNames.search,
                      colorFilter: ColorFilter.mode(
                        theme.hintColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                  ChoiceChip(
                    label: Text('asdf'),
                    selected: true,
                    onSelected: (value) {},
                  ),
                  ChoiceChip(
                    label: Text('123124124'),
                    selected: false,
                    onSelected: (value) {},
                  ),
                  ChoiceChip(
                    label: Text('43434349'),
                    selected: false,
                    onSelected: (value) {},
                  ),
                  ChoiceChip(
                    label: Text('3434'),
                    selected: false,
                    onSelected: (value) {},
                  ),
                  ChoiceChip(
                    label: Text('34343434'),
                    selected: false,
                    onSelected: (value) {},
                  ),
                  ChoiceChip(
                    label: Text('123123123'),
                    selected: false,
                    onSelected: (value) {},
                  ),
                  ChoiceChip(
                    label: Text('asdf'),
                    selected: false,
                    onSelected: (value) {},
                  ),
                  BaseButton(
                    onTap: () {},
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
          SliverList.builder(
            itemCount: 1,
            itemBuilder: (context, index) => MerchCard(count: 0),
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
                      showModalBottomSheet(
                        useRootNavigator: true,
                        context: context,
                        builder: (context) => ImportBottomSheet(),
                      );
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
}

// TODO: Перенести в отдельный виджет
class ImportBottomSheet extends StatelessWidget {
  const ImportBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(32),
      ),
      height: 300,
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        children: [
          Text(
            S.of(context).whereToImportFrom,
            style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
          ),
          Expanded(
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: BaseContainer(
                    onTap: () {},
                    height: 150,
                    elevation: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).fromExcel,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(S.of(context).notAvailableYet),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: BaseContainer(
                    onTap: () {},
                    height: 150,
                    elevation: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).fromCSV,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(S.of(context).recommended),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
