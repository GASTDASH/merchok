import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/analytics/analytics.dart';
import 'package:merchok/features/settings/settings.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const defaultDecoration = PageDecoration(
    bodyFlex: 2,
    imageFlex: 3,
    footerFlex: 0,
    imagePadding: .only(top: 100),
  );

  bool isAppmetricaChecked = false;

  void onDone(BuildContext context) {
    GetIt.I<SettingsRepository>().setOnboardingShown(true);

    final analyticsCubit = context.read<AnalyticsCubit>();
    if (isAppmetricaChecked) {
      analyticsCubit.enable();
    } else {
      analyticsCubit.disable();
    }

    context.go(AppRoutes.home);
  }

  Future<void> openUrl({
    required BuildContext context,
    required ThemeData theme,
    required String url,
  }) async {
    final s = S.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      scaffoldMessenger.hideCurrentSnackBar();
      scaffoldMessenger.showSnackBar(
        SnackBar(
          backgroundColor: theme.colorScheme.error,
          content: Text(s.couldntOpenPage),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IntroductionScreen(
      // Next
      showNextButton: true,
      next: Text(S.of(context).next),
      // Done
      showDoneButton: true,
      done: Text(S.of(context).done),
      onDone: () => onDone(context),
      // Skip
      showSkipButton: true,
      skip: Text(S.of(context).skip),
      // Pages
      pages: [
        PageViewModel(
          title: 'Продавай мерч\nбез головной боли',
          body: 'Учёт продаж за пару кликов. Никаких таблиц и сложностей.',
          image: Center(
            child: SvgPicture.asset('assets/icons/sobaken1.svg', height: 300),
          ),
          decoration: defaultDecoration,
        ),
        PageViewModel(
          title: 'Работает даже без интернета',
          body:
              'Фестиваль, концерт, маркет — связь не нужна. Все ваши данные только у вас.',
          image: Center(
            child: SvgPicture.asset('assets/icons/no_wifi.svg', height: 250),
          ),
          decoration: defaultDecoration,
        ),
        PageViewModel(
          title: 'Отчёты и статистика',
          body: 'В конце дня увидишь, сколько заработал и сколько осталось.',
          image: Center(
            child: SvgPicture.asset('assets/icons/stat_money.svg', height: 250),
          ),
          decoration: defaultDecoration,
        ),
        PageViewModel(
          title: 'Yandex.AppMetrica',
          bodyWidget: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: S.of(context).appmetrica1,
                  style: theme.textTheme.bodyMedium,
                ),
                TextSpan(
                  text: S.of(context).appmetrica2,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => openUrl(
                      context: context,
                      theme: theme,
                      url: 'https://yandex.ru/legal/metrica_termsofuse',
                    ),
                ),
                TextSpan(text: '.\n\n', style: theme.textTheme.bodyMedium),
                TextSpan(
                  text: S.of(context).appmetrica3,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          image: Center(child: SvgPicture.asset('assets/icons/appmetrica.svg')),
          footer: Row(
            children: [
              Checkbox.adaptive(
                value: isAppmetricaChecked,
                onChanged: (value) =>
                    setState(() => isAppmetricaChecked = !isAppmetricaChecked),
              ),
              Flexible(child: Text(S.of(context).appmetrica_agree)),
            ],
          ),
          decoration: PageDecoration(
            imageFlex: 4,
            bodyFlex: 16,
            footerFlex: 2,
            imagePadding: const .only(top: 32),
            imageAlignment: .bottomCenter,
            footerFit: .tight,
            pageMargin: const EdgeInsets.symmetric(
              horizontal: 8,
            ).copyWith(bottom: 16),
            bodyTextStyle: theme.textTheme.bodyMedium!,
          ),
        ),
      ],
    );
  }
}
