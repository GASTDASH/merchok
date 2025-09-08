import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/theme/theme.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
