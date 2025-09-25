import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
    this.iconSize = 24,
    this.onTap,
  });

  final String? icon;
  final double? iconSize;
  final VoidCallback? onTap;
  final String subtitle;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: BaseContainer(
        onTap: onTap,
        padding: EdgeInsets.all(24),
        elevation: 4,
        child: Row(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 12,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title, style: theme.textTheme.headlineSmall),
                      if (icon != null)
                        BaseSvgIcon(context, icon!, width: iconSize),
                    ],
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.hintColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(AppIcons.right),
          ],
        ),
      ),
    );
  }
}
