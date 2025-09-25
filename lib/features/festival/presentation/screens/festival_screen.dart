import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/current_festival/current_festival.dart';
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

  Future<void> handleFestivalStateChanged(
    BuildContext context,
    FestivalState state,
  ) async {
    if (state is FestivalLoaded) {
      final currentFestivalCubit = context.read<CurrentFestivalCubit>();
      final selectedFestival = currentFestivalCubit.state;

      // Если никакой фестиваль не выбран
      if (selectedFestival == null) return;

      // Проверяем, существует ли текущий фестиваль
      final festival = state.festivalList.firstWhereOrNull(
        (f) => f.id == selectedFestival.id,
      );

      // Если фестиваля нет в списке
      if (festival == null) {
        // Фестиваль был удален
        await currentFestivalCubit.handleFestivalDeleted(selectedFestival.id);
      }
      // Если найденный фестиваль отличается
      else if (festival != selectedFestival) {
        // Фестиваль был обновлен
        currentFestivalCubit.handleFestivalUpdated(festival);
      }
    }
  }

  Future<void> deleteFestival(BuildContext context, String festivalId) async {
    return await showDeleteDialog(
      context: context,
      message: S.of(context).deleteThisFestival,
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
    final defaultName = S.of(context).untitled;
    final bloc = context.read<FestivalBloc>();

    String? festivalName = await showAddDialog(context);
    if (festivalName == null) return;
    if (festivalName.isEmpty) festivalName = defaultName;

    bloc.add(FestivalAdd(festivalName: festivalName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BaseSliverAppBar(
            title: S.of(context).festivals,
            actions: [
              IconButton(
                tooltip: S.of(context).add,
                onPressed: () async => await addFestival(context),
                icon: Icon(AppIcons.add, size: 32),
              ),
            ],
          ),
          BlocConsumer<FestivalBloc, FestivalState>(
            listener: (context, state) async =>
                await handleFestivalStateChanged(context, state),
            builder: (context, state) {
              if (state is FestivalLoading) {
                return LoadingBanner(message: state.message);
              } else if (state is FestivalLoaded) {
                if (state.festivalList.isNotEmpty) {
                  return SliverList.separated(
                    itemCount: state.festivalList.length,
                    separatorBuilder: (context, index) =>
                        Divider(indent: 32, endIndent: 32, height: 0),
                    itemBuilder: (context, index) {
                      final cubit = context.watch<CurrentFestivalCubit>();
                      final festival = state.festivalList[index];

                      return FestivalListTile(
                        festival: festival,
                        onTap: () => cubit.selectFestival(festival),
                        onLongPress: () => deleteFestival(context, festival.id),
                        selected: cubit.state?.id == festival.id,
                      );
                    },
                  );
                } else {
                  return InfoBanner(text: S.of(context).noFestivals);
                }
              } else if (state is FestivalError) {
                return ErrorBanner(message: state.error.toString());
              } else if (state is FestivalInitial) {
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
