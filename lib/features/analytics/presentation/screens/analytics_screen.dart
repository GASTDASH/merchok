import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/analytics/analytics.dart';
import 'package:merchok/generated/l10n.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  late final AnalyticsCubit analyticsCubit;

  @override
  void initState() {
    super.initState();

    analyticsCubit = context.read<AnalyticsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BaseSliverAppBar(title: S.of(context).dataCollection),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverToBoxAdapter(
              child: BlocBuilder<AnalyticsCubit, AnalyticsState>(
                bloc: analyticsCubit,
                builder: (context, state) {
                  return RadioGroup(
                    groupValue: state.enabled,
                    onChanged: (enabled) {
                      if (enabled == null) return;
                      if (enabled) {
                        analyticsCubit.enable();
                      } else {
                        analyticsCubit.disable();
                      }
                    },
                    child: Column(
                      children: [
                        SettingsRadioOption(
                          text: S.of(context).enabled1,
                          value: true,
                        ),
                        SettingsRadioOption(
                          text: S.of(context).disabled1,
                          value: false,
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
