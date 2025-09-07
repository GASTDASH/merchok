import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';

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
            Text(
              'RuBronyCon 2025',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
