import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:merchok/features/cart/cart.dart';
import 'package:merchok/features/category/category.dart';
import 'package:merchok/features/current_festival/current_festival.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/language/language.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/payment_method/payment_method.dart';
import 'package:merchok/features/settings/settings.dart';
import 'package:merchok/features/stock/stock.dart';
import 'package:merchok/features/theme/theme.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:merchok/routing/router.dart';
import 'package:merchok/theme/theme.dart';

class MerchokApp extends StatelessWidget {
  const MerchokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LanguageCubit(settingsRepository: GetIt.I<SettingsRepository>()),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(
            initialThemeStyle: ThemeStyle.light,
            settingsRepository: GetIt.I<SettingsRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              MerchBloc(merchRepository: GetIt.I<MerchRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              CartBloc(cartRepository: GetIt.I.call<CartRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              FestivalBloc(festivalRepository: GetIt.I<FestivalRepository>()),
        ),
        BlocProvider(
          create: (context) => CurrentFestivalCubit(
            festivalRepository: GetIt.I<FestivalRepository>(),
            settingsRepository: GetIt.I<SettingsRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => PaymentMethodBloc(
            paymentMethodRepository: GetIt.I<PaymentMethodRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              OrderBloc(orderRepository: GetIt.I<OrderRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              CategoryBloc(categoryRepository: GetIt.I<CategoryRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              StockBloc(stockRepository: GetIt.I<StockRepository>()),
        ),
      ],
      child: BlocSelector<ThemeCubit, ThemeState, ThemeStyle>(
        selector: (state) => state.themeStyle,
        builder: (context, themeStyle) {
          return BlocSelector<LanguageCubit, LanguageState, String?>(
            selector: (state) => state.languageCode,
            builder: (context, languageCode) {
              return MaterialApp.router(
                title: 'MerchOK',
                routerConfig: router,
                theme: themes[themeStyle],
                locale: languageCode != null
                    ? Locale.fromSubtags(languageCode: languageCode)
                    : null,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
              );
            },
          );
        },
      ),
    );
  }
}
