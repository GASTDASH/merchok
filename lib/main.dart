import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:merchok/features/language/presentation/cubit/language_cubit.dart';
import 'package:merchok/features/theme/theme.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:merchok/routing/router.dart';
import 'package:merchok/theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageCubit(initialLanguageCode: 'en'),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(themeStyle: ThemeStyle.light),
        ),
      ],
      child: BlocSelector<ThemeCubit, ThemeState, ThemeStyle>(
        selector: (state) => state.themeStyle,
        builder: (context, themeStyle) {
          return BlocSelector<LanguageCubit, LanguageState, String>(
            selector: (state) => state.languageCode,
            builder: (context, languageCode) {
              return MaterialApp.router(
                title: 'MerchOK',
                routerConfig: router,
                theme: themes[themeStyle],
                locale: Locale.fromSubtags(languageCode: languageCode),
                localizationsDelegates: [
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
