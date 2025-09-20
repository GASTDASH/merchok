import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';

class ExportCard extends StatelessWidget {
  const ExportCard({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  final String icon;
  final VoidCallback? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseContainer(
      onTap: onTap,
      height: 230,
      padding: EdgeInsets.all(24),
      elevation: 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(child: SvgPicture.asset(icon, width: double.infinity)),
        ],
      ),
    );
  }
}
