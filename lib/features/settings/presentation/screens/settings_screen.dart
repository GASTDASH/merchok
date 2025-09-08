import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/settings/settings.dart';
import 'package:merchok/generated/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            sliver: SliverList.list(
              children: [
                SettingsButton(
                  onTap: () {},
                  title: S.of(context).theme,
                  subtitle: S.of(context).themeDescription,
                  icon: IconNames.theme,
                  iconSize: 32,
                ),
                SettingsButton(
                  onTap: () {},
                  title: S.of(context).language,
                  subtitle: S.of(context).languageDescription,
                  icon: IconNames.language,
                  iconSize: 32,
                ),
                SettingsButton(
                  onTap: () {},
                  title: S.of(context).dataExport,
                  subtitle: S.of(context).exportDataDescription,
                  icon: IconNames.downloadPackage,
                ),
                SettingsButton(
                  onTap: () {},
                  title: S.of(context).paymentMethods,
                  subtitle: S.of(context).paymentMethodsDescription,
                  icon: IconNames.payment,
                ),
                SettingsButton(
                  onTap: () {},
                  title: S.of(context).about,
                  subtitle: S.of(context).aboutDescription,
                  icon: IconNames.info,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
