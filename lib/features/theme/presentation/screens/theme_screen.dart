import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/theme/theme.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:merchok/theme/theme.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  late final ThemeCubit themeCubit;

  @override
  void initState() {
    super.initState();

    themeCubit = context.read<ThemeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BaseSliverAppBar(title: S.of(context).theme),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverToBoxAdapter(
              child: BlocBuilder<ThemeCubit, ThemeState>(
                bloc: themeCubit,
                builder: (context, state) {
                  return RadioGroup(
                    groupValue: state.themeStyle,
                    onChanged: (newThemeStyle) {
                      if (newThemeStyle == null) return;
                      themeCubit.changeTheme(newThemeStyle);
                    },
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
