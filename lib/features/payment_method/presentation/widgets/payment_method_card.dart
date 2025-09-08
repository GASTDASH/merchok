import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    this.icon,
  });

  final String title;
  final String subtitle;
  final String description;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseContainer(
      onTap: () {},
      margin: EdgeInsets.symmetric(vertical: 12),
      padding: EdgeInsets.all(24),
      elevation: 8,
      child: Row(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (icon != null) SvgPicture.asset(icon!, height: 32),
                  ],
                ),
                Text(subtitle, style: theme.textTheme.headlineSmall),
                Text(description, style: theme.textTheme.bodyLarge),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              IconNames.delete,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
