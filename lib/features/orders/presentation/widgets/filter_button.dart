import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, required this.active, this.onTap});

  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseButton.outlined(
      onTap: onTap,
      color: theme.colorScheme.onSurface,
      backgroundColor: active ? theme.hintColor.withAlpha(32) : null,
      child: Row(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: [Text(S.of(context).filter), Icon(AppIcons.filter)],
      ),
    );
  }
}
