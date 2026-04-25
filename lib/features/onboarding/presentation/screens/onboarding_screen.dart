import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isAppmetricaChecked = false;

  void onDone() {
    // save isAppmetricaChecked;
    // save onboardingShown;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IntroductionScreen(
      // Next
      showNextButton: true,
      next: const Text('Next'),
      // Done
      showDoneButton: true,
      done: const Text('Done'),
      onDone: () {},
      // Skip
      showSkipButton: true,
      skip: const Text('Skip'),
      // Pages
      pages: [
        PageViewModel(
          title: 'Продавай мерч\nбез головной боли',
          body: 'Учёт продаж за пару кликов. Никаких таблиц и сложностей.',
          image: Center(child: SvgPicture.asset('assets/icons/sobaken1.svg')),
        ),
        PageViewModel(
          title: 'Работает даже без интернета',
          body:
              'Фестиваль, концерт, маркет — связь не нужна. Все ваши данные только у вас.',
          image: Center(child: SvgPicture.asset('assets/icons/no_wifi.svg')),
        ),
        PageViewModel(
          title: 'Отчёты и статистика',
          body: 'В конце дня увидишь, сколько заработал и сколько осталось.',
          image: Center(child: SvgPicture.asset('assets/icons/stat_money.svg')),
        ),
        PageViewModel(
          title: 'Yandex.AppMetrica',
          body:
              """Это приложение использует сервис аналитики AppMetrica, предоставляемый компанией ООО «ЯНДЕКС» на Условиях использования сервиса.

AppMetrica анализирует данные об использовании приложения, в том числе об устройстве, на котором оно функционирует, источнике установки, составляет конверсию и статистику вашей активности в целях продуктовой аналитики, анализа и оптимизации рекламных кампаний, а также для устранения ошибок. Собранная таким образом информация не может идентифицировать вас.

Информация об использовании вами данного приложения, собранная при помощи инструментов AppMetrica, в обезличенном виде будет передаваться Яндексу и храниться на сервере Яндекса в ЕС и Российской Федерации. Яндекс будет обрабатывать эту информацию для предоставления статистики использования вами приложения, составления для нас отчетов о работе приложения и предоставления других услуг.""",
          image: Center(child: SvgPicture.asset('assets/icons/appmetrica.svg')),
          footer: Row(
            children: [
              Checkbox.adaptive(
                value: isAppmetricaChecked,
                onChanged: (value) =>
                    setState(() => isAppmetricaChecked = !isAppmetricaChecked),
              ),
              const Flexible(
                child: Text(
                  'Я согласен на отправку статистических данных для улучшения качества приложения',
                ),
              ),
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
