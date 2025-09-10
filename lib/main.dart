import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:merchok/features/language/language.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/settings/settings.dart';
import 'package:merchok/features/theme/theme.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:merchok/routing/router.dart';
import 'package:merchok/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final settingsRepository = SettingsRepositoryImpl(prefs: prefs);
  GetIt.I.registerSingleton<SettingsRepository>(settingsRepository);

  final merchRepository = MerchRepositoryImpl();
  GetIt.I.registerSingleton<MerchRepository>(merchRepository);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
