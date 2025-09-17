import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';

class AddButton extends StatelessWidget {
  const AddButton({
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
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(16),
          dashPattern: [4, 4],
          color: theme.colorScheme.onSurface,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [Text(text), BaseSvgIcon(context, icon)],
          ),
        ),
      ),
    );
  }
}
