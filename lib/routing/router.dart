// translate-me-ignore-all-file

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/about/about.dart';
import 'package:merchok/features/analytics/analytics.dart';
import 'package:merchok/features/export/export.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/home/home.dart';
import 'package:merchok/features/language/language.dart';
import 'package:merchok/features/onboarding/onboarding.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/payment_method/payment_method.dart';
import 'package:merchok/features/root/root.dart';
import 'package:merchok/features/scanner/scanner.dart';
import 'package:merchok/features/settings/settings.dart';
import 'package:merchok/features/stat/stat.dart';
import 'package:merchok/features/stock/stock.dart';
import 'package:merchok/features/theme/theme.dart';
import 'package:talker_flutter/talker_flutter.dart';

String get _initialRoute => GetIt.I<SettingsRepository>().isOnboardingShown
    ? AppRoutes.home
    : AppRoutes.onboarding;

final router = GoRouter(
  observers: [TalkerRouteObserver(GetIt.I<Talker>())],
  initialLocation: _initialRoute,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          RootScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'home',
              path: AppRoutes.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'orders',
              path: AppRoutes.orders,
              builder: (context, state) => const OrdersScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'stat',
              path: AppRoutes.stat,
              builder: (context, state) => const StatScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'settings',
              path: AppRoutes.settings,
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: 'festival',
      path: AppRoutes.festival,
      pageBuilder: (context, state) =>
          SlideDownTransitionPage(state: state, child: const FestivalScreen()),
    ),
    GoRoute(
      name: 'theme',
      path: AppRoutes.theme,
      builder: (context, state) => const ThemeScreen(),
    ),
    GoRoute(
      name: 'language',
      path: AppRoutes.language,
      builder: (context, state) => const LanguageScreen(),
    ),
    GoRoute(
      name: 'export',
      path: AppRoutes.export,
      builder: (context, state) => const ExportScreen(),
    ),
    GoRoute(
      name: 'payment_methods',
      path: AppRoutes.paymentMethods,
      builder: (context, state) => const PaymentMethodsScreen(),
    ),
    GoRoute(
      name: 'festivals_history',
      path: AppRoutes.festivalsHistory,
      builder: (context, state) => const FestivalsHistoryScreen(),
    ),
    GoRoute(
      name: 'popular_merch',
      path: AppRoutes.popularMerch,
      builder: (context, state) => const PopularMerchScreen(),
    ),
    GoRoute(
      name: 'about',
      path: AppRoutes.about,
      builder: (context, state) => const AboutScreen(),
      routes: [
        GoRoute(
          name: AppRoutes.privacyPolicyName,
          path: '${AppRoutes.privacyPolicyName}/:languageCode',
          builder: (context, state) => PrivacyPolicyScreen(
            languageCode: state.pathParameters['languageCode']!,
          ),
        ),
        GoRoute(
          name: AppRoutes.termsConditionsName,
          path: '${AppRoutes.termsConditionsName}/:languageCode',
          builder: (context, state) => TermsConditionsScreen(
            languageCode: state.pathParameters['languageCode']!,
          ),
        ),
      ],
    ),
    GoRoute(
      name: 'scan',
      path: AppRoutes.scan,
      builder: (context, state) => const ScannerScreen(),
    ),
    GoRoute(
      name: 'stock',
      path: AppRoutes.stock,
      builder: (context, state) => const StockScreen(),
    ),
    GoRoute(
      name: AppRoutes.onboardingName,
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      name: AppRoutes.analyticsName,
      path: AppRoutes.analytics,
      builder: (context, state) => const AnalyticsScreen(),
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
              position:
                  Tween(
                    begin: const Offset(0, -1),
                    end: const Offset(0, 0),
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOutCubic,
                    ),
                  ),
              child: child,
            ),
      );
}
