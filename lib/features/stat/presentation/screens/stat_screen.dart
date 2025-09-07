import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/theme/theme.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildListDelegate([
                StatCard(
                  onTap: () {},
                  text: 'Общая статистика продаж',
                  icon: IconNames.graph,
                ),
                StatCard(
                  onTap: () {},
                  text: 'Популярный мерч',
                  icon: IconNames.like,
                ),
                StatCard(
                  onTap: () {},
                  text: 'История фестивалей',
                  icon: IconNames.presentation,
                ),
                StatCard(
                  onTap: () {},
                  text: 'Средний чек',
                  icon: IconNames.dollar,
                ),
                StatCard(
                  onTap: () {},
                  text: 'Предпочтения покупателей',
                  icon: IconNames.book,
                ),
                StatCard(
                  onTap: () {},
                  text: 'Выгода',
                  icon: IconNames.discount,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  final String text;
  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      onTap: onTap,
      height: 400,
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(child: SvgPicture.asset(icon, width: double.infinity)),
        ],
      ),
    );
  }
}
