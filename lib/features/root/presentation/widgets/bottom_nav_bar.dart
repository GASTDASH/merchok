import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/root/root.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).hintColor, width: 2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavItem(
              onTap: () => context.go('/home'),
              icon: IconNames.house,
              selected: index == 0,
            ),
            NavItem(
              onTap: () => context.go('/orders'),
              icon: IconNames.archive,
              selected: index == 1,
            ),
            SizedBox(width: 64),
            NavItem(
              onTap: () => context.go('/stat'),
              icon: IconNames.chartBar,
              selected: index == 2,
            ),
            NavItem(
              onTap: () => context.go('/settings'),
              icon: IconNames.settings,
              selected: index == 3,
            ),
          ],
        ),
      ),
    );
  }
}
