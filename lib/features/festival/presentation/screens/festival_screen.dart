import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/generated/l10n.dart';

class FestivalScreen extends StatefulWidget {
  const FestivalScreen({super.key});

  @override
  State<FestivalScreen> createState() => _FestivalScreenState();
}

class _FestivalScreenState extends State<FestivalScreen> {
  @override
  void initState() {
    super.initState();

    context.read<FestivalBloc>().add(FestivalLoad());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BaseSliverAppBar(
            title: S.of(context).festivals,
            actions: [
              IconButton(
                tooltip: S.of(context).add,
                onPressed: () async => await addFestival(context),
                icon: SvgPicture.asset(
                  IconNames.add,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                  height: 32,
                ),
              ),
            ],
          ),
          BlocBuilder<FestivalBloc, FestivalState>(
            builder: (context, state) {
              if (state is FestivalLoading) {
                return SliverFillRemaining(
                  child: SpinKitSpinningLines(
                    color: theme.colorScheme.onSurface,
                  ),
                );
              } else if (state is FestivalLoaded) {
                if (state.festivalList.isNotEmpty) {
                  return SliverList.separated(
                    itemCount: state.festivalList.length,
                    separatorBuilder: (context, index) =>
                        Divider(indent: 32, endIndent: 32, height: 0),
                    itemBuilder: (context, index) {
                      final festival = state.festivalList[index];
                      return FestivalListTile(
                        festival: festival,
                        onTap: () {},
                        onLongPress: () => deleteFestival(context, festival.id),
                      );
                    },
                  );
                } else {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          S.of(context).noFestivals,
                          style: theme.textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }
              } else if (state is FestivalError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      S.of(context).somethingWentWrong,
                      style: theme.textTheme.headlineMedium,
                    ),
                  ),
                );
              } else if (state is FestivalInitial) {
                return SliverFillRemaining();
              } else {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      S.of(context).unexpectedState,
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

  Future<void> deleteFestival(BuildContext context, String festivalId) async {
    return await showDeleteDialog(
      context: context,
      message: 'Удалить этот фестиваль?',
      onYes: () {
        context.pop();
        context.read<FestivalBloc>().add(
          FestivalDelete(festivalId: festivalId),
        );
      },
      onNo: () {
        context.pop();
      },
    );
  }

  Future<void> addFestival(BuildContext context) async {
    final bloc = context.read<FestivalBloc>();

    String? festivalName = await showAddDialog(context);
    if (festivalName == null) return;
    if (festivalName.isEmpty) festivalName = 'Без названия';

    bloc.add(FestivalAdd(festivalName: festivalName));
  }
}
