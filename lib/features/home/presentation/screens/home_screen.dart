import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:merchok/core/core.dart';
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
  @override
  void initState() {
    super.initState();

    context.read<MerchBloc>().add(MerchLoad());
  }

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
          BlocBuilder<MerchBloc, MerchState>(
            builder: (context, state) {
              if (state is MerchLoading) {
                return SliverFillRemaining(
                  child: SpinKitSpinningLines(
                    color: theme.colorScheme.onSurface,
                  ),
                );
              } else if (state is MerchLoaded) {
                if (state.merchList.isNotEmpty) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverMainAxisGroup(
                      slivers: [
                        SliverList.builder(
                          itemCount: state.merchList.length,
                          itemBuilder: (context, index) => MerchCard(
                            merch: state.merchList[index],
                            count: 0,
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.only(top: 12, bottom: 128),
                          sliver: SliverToBoxAdapter(
                            child: addButtons(context),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              'У вас пока нет мерча',
                              style: theme.textTheme.headlineMedium,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: addButtons(context),
                          ),
                        ),
                        SizedBox(height: 128),
                      ],
                    ),
                  );
                }
              } else if (state is MerchError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'Что-то пошло не так',
                      style: theme.textTheme.headlineMedium,
                    ),
                  ),
                );
              } else if (state is MerchInitial) {
                return SliverFillRemaining();
              } else {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'Unexpected state',
                      style: theme.textTheme.headlineMedium,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget addButtons(BuildContext context) {
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
