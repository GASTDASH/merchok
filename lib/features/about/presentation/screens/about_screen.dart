import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/settings/settings.dart';
import 'package:merchok/generated/l10n.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BaseSliverAppBar(title: S.of(context).about),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
            sliver: SliverToBoxAdapter(
              child: Column(
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
                  Text(
                    'Version 0.2.0_alpha', // translate-me-ignore
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 24),
                  const _DevelopedBy(),
                  const SizedBox(height: 24),
                  const _PrivacyPolicy(),
                  const SizedBox(height: 24),
                  const _TermsAndConditions(),
                  const SizedBox(height: 24),
                  const _SpecialThanks(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DevelopedBy extends StatelessWidget {
  const _DevelopedBy();

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
            S.of(context).developedBy,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).gastdash,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
              const SizedBox(child: LinkText(url: 'https://vk.com/gastdash')),
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
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).privacyPolicy,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              BaseButton(
                onTap: () {
                  final languageCode =
                      GetIt.I<SettingsRepository>().currentLanguageCode ?? "en";
                  context.push('/about/privacy_policy/$languageCode');
                },
                child: Text(S.of(context).view),
              ),
            ],
          ),
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
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).termsAndConditions,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              BaseButton(
                onTap: () {
                  final languageCode =
                      GetIt.I<SettingsRepository>().currentLanguageCode ?? "en";
                  context.push('/about/terms_conditions/$languageCode');
                },
                child: Text(S.of(context).view),
              ),
            ],
          ),
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
