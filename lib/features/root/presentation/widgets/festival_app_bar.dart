import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/current_festival/current_festival.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/stock/stock.dart';
import 'package:merchok/generated/l10n.dart';

class FestivalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FestivalAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: theme.hintColor)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: BlocBuilder<FestivalBloc, FestivalState>(
                builder: (context, state) {
                  final cubit = context.watch<CurrentFestivalCubit>();

                  if (state is FestivalLoading) {
                    return Row(
                      spacing: 12,
                      children: [
                        Text(
                          S.of(context).loading,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const LoadingIndicator(size: 32),
                      ],
                    );
                  }
                  if (state is FestivalLoaded &&
                      state.festivalList.isNotEmpty &&
                      cubit.state != null) {
                    return Text(
                      state.festivalList
                          .firstWhere((f) => f.id == cubit.state!.id)
                          .name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return Text(
                    S.of(context).festivalNotSelected,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ),
            BlocBuilder<StockBloc, StockState>(
              builder: (context, state) {
                if (state is StockLoaded) {
                  return GestureDetector(
                    onTap: () {
                      context.push('/stock');
                    },
                    child: const Icon(AppIcons.cube),
                  );
                }
                if (state is StockLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is StockError) {
                  return Tooltip(
                    triggerMode: TooltipTriggerMode.tap,
                    message: state.error.toString(),
                    child: const Icon(Icons.warning_amber_rounded),
                  );
                } else {
                  return Tooltip(
                    triggerMode: TooltipTriggerMode.tap,
                    message: '$state',
                    child: const Icon(Icons.warning_amber_rounded),
                  );
                }
              },
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                context.push('/festival');
              },
              child: const Icon(AppIcons.calendar),
            ),
          ],
        ),
      ),
    );
  }
}
