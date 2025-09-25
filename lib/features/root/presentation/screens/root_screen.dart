import 'package:flutter/material.dart';
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
  Future<void> showCartBottomSheet(BuildContext context) {
    return showBaseDraggableBottomSheet(
      context: context,
      builder: (context) => CartBottomSheet(),
    );
  }

  Future<void> showExitDialog(BuildContext context) {
    return showDialog(context: context, builder: (context) => ExitDialog());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final index = widget.navigationShell.currentIndex;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        await showExitDialog(context);
      },
      child: Container(
        color: theme.scaffoldBackgroundColor,
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: FestivalAppBar(),
            body: widget.navigationShell,
            floatingActionButton: SizedBox(
              height: 64,
              width: 64,
              child: FloatingActionButton(
                onPressed: () => showCartBottomSheet(context),
                backgroundColor: theme.primaryColor,
                child: Icon(
                  AppIcons.shoppingBag,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavBar(index: index),
          ),
        ),
      ),
    );
  }
}
