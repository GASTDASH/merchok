import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/generated/l10n.dart';

class FestivalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FestivalAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(70);

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
                        SpinKitSpinningLines(
                          color: theme.colorScheme.onSurface,
                          size: 32,
                        ),
                      ],
                    );
                  } else if (state is FestivalLoaded &&
                      state.selectedFestival != null) {
                    return Text(
                      state.selectedFestival!.name,
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
              icon: SvgPicture.asset(
                IconNames.calendar,
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
