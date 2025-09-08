import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:merchok/theme/theme.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  ThemeStyle? themeStyle = ThemeStyle.light;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BaseSliverAppBar(title: S.of(context).theme),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverToBoxAdapter(
              child: RadioGroup(
                groupValue: themeStyle,
                onChanged: (value) => setState(() => themeStyle = value),
                child: Column(
                  children: [
                    SettingsRadioOption(
                      text: S.of(context).light,
                      value: ThemeStyle.light,
                    ),
                    SettingsRadioOption(
                      text: S.of(context).dark,
                      value: ThemeStyle.dark,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
