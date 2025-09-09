import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/language/language.dart';
import 'package:merchok/generated/l10n.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late final LanguageCubit languageCubit;

  @override
  void initState() {
    super.initState();

    languageCubit = context.read<LanguageCubit>();
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
              child: BlocBuilder<LanguageCubit, LanguageState>(
                bloc: languageCubit,
                builder: (context, state) {
                  return RadioGroup(
                    groupValue: state.languageCode,
                    onChanged: (newLanguageCode) {
                      if (newLanguageCode == null) return;
                      languageCubit.changeLanguage(newLanguageCode);
                    },
                    child: Column(
                      children: [
                        for (Locale l in S.delegate.supportedLocales)
                          SettingsRadioOption(
                            text: languageCodes[l.toLanguageTag()]!,
                            value: l.languageCode,
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
