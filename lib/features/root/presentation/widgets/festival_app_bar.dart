import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/current_festival/current_festival.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/generated/l10n.dart';

class FestivalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FestivalAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PreferredSize(
      preferredSize: Size.fromHeight(70),
      child: Container(
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 32),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: theme.hintColor)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: BlocBuilder<FestivalBloc, FestivalState>(
                builder: (context, state) {
                  final cubit = context.read<CurrentFestivalCubit>();

                  if (state is FestivalLoading) {
                    return Row(
                      spacing: 12,
                      children: [
                        Text(
                          S.of(context).loading,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        LoadingIndicator(size: 32),
                      ],
                    );
                  } else if (state is FestivalLoaded &&
                      state.festivalList.isNotEmpty &&
                      cubit.state != null) {
                    return Text(
                      state.festivalList
                          .firstWhere((f) => f.id == cubit.state!.id)
                          .name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return Text(
                    S.of(context).festivalNotSelected,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  );
                },
              ),
            ),
            IconButton(
              onPressed: () {
                context.push('/festival');
              },
              icon: BaseSvgIcon(context, IconNames.calendar),
            ),
          ],
        ),
      ),
    );
  }
}
