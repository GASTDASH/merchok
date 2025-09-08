import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class FestivalScreen extends StatelessWidget {
  const FestivalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BaseSliverAppBar(
            title: S.of(context).festivals,
            actions: [
              IconButton(
                tooltip: S.of(context).add,
                onPressed: () {
                  showAddDialog(context);
                },
                icon: SvgPicture.asset(
                  IconNames.add,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                  height: 32,
                ),
              ),
            ],
          ),
          SliverList.separated(
            itemCount: 10,
            separatorBuilder: (context, index) =>
                Divider(indent: 32, endIndent: 32, height: 0),
            itemBuilder: (context, index) => ListTile(
              onTap: () {},
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 24,
              ),
              title: Row(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'RuBronyCon 2025',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      IconNames.edit,
                      colorFilter: ColorFilter.mode(
                        theme.colorScheme.onSurface,
                        BlendMode.srcIn,
                      ),
                      height: 16,
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                S.of(context).creationDate,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: theme.hintColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
