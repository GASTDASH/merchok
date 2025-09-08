import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.hintColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).search,
            style: theme.textTheme.bodyLarge?.copyWith(color: theme.hintColor),
          ),
          SvgPicture.asset(
            IconNames.search,
            colorFilter: ColorFilter.mode(theme.hintColor, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}
