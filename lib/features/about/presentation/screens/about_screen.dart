import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/settings/settings.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BaseSliverAppBar(title: S.of(context).about),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
            sliver: SliverToBoxAdapter(
              child: Column(
                spacing: 24,
                children: [
                  _TitleInfo(),
                  _DevelopedBy(),
                  _PrivacyPolicy(),
                  _TermsAndConditions(),
                  _GitHubInfo(),
                  _SpecialThanks(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleInfo extends StatelessWidget {
  const _TitleInfo();

  Future<String> getAppVersion() async =>
      (await PackageInfo.fromPlatform()).version;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          height: 128,
          width: 128,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/Merchok Icon.png'),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'MerchOK',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        FutureBuilder(
          future: getAppVersion(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                '${S.of(context).version} ${snapshot.data!}',
                style: theme.textTheme.titleMedium,
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            }
            if (snapshot.hasError) {
              log(snapshot.error.toString());
              return Text(S.of(context).loadingError);
            }
            return Text(S.of(context).noDataToDisplay);
          },
        ),
      ],
    );
  }
}

class _DevelopedBy extends StatelessWidget {
  const _DevelopedBy();

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

    return BaseContainer(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).developedBy,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(),
          Text(
            S.of(context).gastdash,
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
          ),
          Column(
            spacing: 6,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).alexeyShcherbakov,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
              Text(
                S.of(context).flutterMobile,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 14,
                  color: theme.hintColor.withAlpha(100),
                ),
              ),
            ],
          ),
          Material(
            color: theme.cardColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: [
                  InkResponse(
                    onTap: () async => await openUrl(
                      context: context,
                      theme: theme,
                      // translate-me-ignore-next-line
                      url: 'https://vk.com/gastdash',
                    ),
                    child: SvgPicture.asset(IconNames.vk, height: 52),
                  ),
                  InkResponse(
                    onTap: () async => await openUrl(
                      context: context,
                      theme: theme,
                      // translate-me-ignore-next-line
                      url: 'mailto:gastdash@gmail.com',
                    ),
                    child: SvgPicture.asset(IconNames.mail, height: 52),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            spacing: 8,
            children: [
              Expanded(child: Divider(color: theme.hintColor.withAlpha(32))),
              // translate-me-ignore-next-line
              const Text('© 2026'),
              Expanded(child: Divider(color: theme.hintColor.withAlpha(32))),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivacyPolicy extends StatelessWidget {
  const _PrivacyPolicy();

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      onTap: () {
        final languageCode =
            GetIt.I<SettingsRepository>().currentLanguageCode ?? "en";
        context.push(AppRoutes.privacyPolicy(languageCode));
      },
      inkWellAnimation: true,
      width: .infinity,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            S.of(context).privacyPolicy,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}

class _TermsAndConditions extends StatelessWidget {
  const _TermsAndConditions();

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      onTap: () {
        final languageCode =
            GetIt.I<SettingsRepository>().currentLanguageCode ?? "en";
        context.push(AppRoutes.termsAndConditions(languageCode));
      },
      inkWellAnimation: true,
      width: .infinity,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            S.of(context).termsAndConditions,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}

class _GitHubInfo extends StatelessWidget {
  const _GitHubInfo();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseContainer(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).githubRepository,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const LinkText(url: 'https://github.com/gastdash/merchok'),
        ],
      ),
    );
  }
}

class _SpecialThanks extends StatelessWidget {
  const _SpecialThanks();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseContainer(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).specialThanks,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).jjsh,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
              const LinkText(url: 'https://vk.com/jennifer_house_jjsh'),
            ],
          ),
        ],
      ),
    );
  }
}
