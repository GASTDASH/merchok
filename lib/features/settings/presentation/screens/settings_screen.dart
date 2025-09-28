import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/settings/settings.dart';
import 'package:merchok/generated/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> showDonateDialog(BuildContext context) async {
    return await showAdaptiveDialog(
      context: context,
      builder: (context) => const DonateDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            sliver: SliverList.list(
              children: [
                SettingsButton(
                  onTap: () => context.push('/theme'),
                  title: S.of(context).theme,
                  subtitle: S.of(context).themeDescription,
                  icon: AppIcons.theme,
                ),
                SettingsButton(
                  onTap: () => context.push('/language'),
                  title: S.of(context).language,
                  subtitle: S.of(context).languageDescription,
                  icon: AppIcons.language,
                ),
                SettingsButton(
                  onTap: () => context.push('/export'),
                  title: S.of(context).dataExport,
                  subtitle: S.of(context).exportDataDescription,
                  icon: AppIcons.downloadPackage,
                ),
                SettingsButton(
                  onTap: () => context.push('/payment_methods'),
                  title: S.of(context).paymentMethods,
                  subtitle: S.of(context).paymentMethodsDescription,
                  icon: AppIcons.creditCard,
                ),
                SettingsButton(
                  onTap: () => showDonateDialog(context),
                  title: S.of(context).donate,
                  subtitle: S.of(context).donateDescription,
                  icon: AppIcons.gift,
                ),
                SettingsButton(
                  onTap: () => context.push('/about'),
                  title: S.of(context).about,
                  subtitle: S.of(context).aboutDescription,
                  icon: AppIcons.info,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
