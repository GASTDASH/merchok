import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merchok/core/constants/language_codes.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String? locale;

  @override
  void initState() {
    super.initState();

    locale = Intl.getCurrentLocale();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BaseSliverAppBar(title: S.of(context).language),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverToBoxAdapter(
              child: RadioGroup(
                groupValue: locale,
                onChanged: (value) => setState(() => locale = value),
                child: Column(
                  children: [
                    for (Locale l in S.delegate.supportedLocales)
                      SettingsRadioOption(
                        text: languageCodes[l.toLanguageTag()]!,
                        value: l.languageCode,
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
