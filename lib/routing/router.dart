import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
import 'package:talker_flutter/talker_flutter.dart';

final router = GoRouter(
  observers: [TalkerRouteObserver(GetIt.I<Talker>())],
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          RootScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'home',
              path: '/home',
              builder: (context, state) => HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'orders',
              path: '/orders',
              builder: (context, state) => OrdersScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'stat',
              path: '/stat',
              builder: (context, state) => StatScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'settings',
              path: '/settings',
              builder: (context, state) => SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: 'festival',
      path: '/festival',
      pageBuilder: (context, state) =>
          SlideDownTransitionPage(state: state, child: FestivalScreen()),
    ),
    GoRoute(
      name: 'theme',
      path: '/theme',
      builder: (context, state) => ThemeScreen(),
    ),
    GoRoute(
      name: 'language',
      path: '/language',
      builder: (context, state) => LanguageScreen(),
    ),
    GoRoute(
      name: 'export',
      path: '/export',
      builder: (context, state) => ExportScreen(),
    ),
    GoRoute(
      name: 'payment_methods',
      path: '/payment_methods',
      builder: (context, state) => PaymentMethodsScreen(),
    ),
    GoRoute(
      name: 'festivals_history',
      path: '/festivals_history',
      builder: (context, state) => FestivalsHistoryScreen(),
    ),
  ],
);

class SlideDownTransitionPage extends CustomTransitionPage<void> {
  SlideDownTransitionPage({required GoRouterState state, required super.child})
    : super(
        key: state.pageKey,
        name: state.name,
        arguments: {
          'pathParameters': state.pathParameters,
          'queryParameters': state.uri.queryParameters,
        },
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
      );
}
