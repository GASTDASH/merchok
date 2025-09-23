import 'package:flutter/material.dart';
import 'package:merchok/features/stat/stat.dart';

class PastFestivalsList extends StatelessWidget {
  const PastFestivalsList({super.key, required this.historyFestivals});

  final List<HistoryFestival> historyFestivals;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverPadding(
      padding: EdgeInsets.all(24),
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: Text(
              'Прошедшие фестивали',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: Divider(height: 48)),
          SliverList.separated(
            itemCount: historyFestivals.length,
            itemBuilder: (context, i) {
              return FestivalsHistoryTile(festivalHistory: historyFestivals[i]);
            },
            separatorBuilder: (context, index) => Divider(height: 48),
          ),
        ],
      ),
    );
  }
}
