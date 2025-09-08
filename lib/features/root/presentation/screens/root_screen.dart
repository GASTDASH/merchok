import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/cart/cart.dart';
import 'package:merchok/features/root/root.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final index = widget.navigationShell.currentIndex;

    return Scaffold(
      appBar: FestivalAppBar(),
      body: widget.navigationShell,
      floatingActionButton: SizedBox(
        height: 64,
        width: 64,
        child: FloatingActionButton(
          onPressed: () {
            showCartBottomSheet(context);
          },
          backgroundColor: theme.primaryColor,
          child: SvgPicture.asset(IconNames.shoppingBag, height: 32),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: theme.hintColor, width: 2)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
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
              SizedBox(width: 32),
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
      ),
    );
  }

  Future<dynamic> showCartBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      context: context,
      builder: (context) => CartBottomSheet(),
    );
  }
}
