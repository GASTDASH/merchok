import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/features/export/export.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/home/home.dart';
import 'package:merchok/features/language/language.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/payment_method/payment_method.dart';
import 'package:merchok/features/root/root.dart';
import 'package:merchok/features/settings/settings.dart';
import 'package:merchok/features/stat/stat.dart';
import 'package:merchok/features/theme/theme.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) =>
          buildFadeTransitionPage(RootScreen(navigationShell: navigationShell)),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/orders',
              builder: (context, state) => OrdersScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/stat', builder: (context, state) => StatScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/festival',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: FestivalScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
              position: Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutCubic,
                ),
              ),
              child: child,
            ),
      ),
    ),
    GoRoute(path: '/theme', builder: (context, state) => ThemeScreen()),
    GoRoute(path: '/language', builder: (context, state) => LanguageScreen()),
    GoRoute(path: '/export', builder: (context, state) => ExportScreen()),
    GoRoute(
      path: '/payment_methods',
      builder: (context, state) => PaymentMethodsScreen(),
    ),
  ],
);

CustomTransitionPage<dynamic> buildFadeTransitionPage(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
