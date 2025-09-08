import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, this.controller});

  final TextEditingController? controller;

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
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: S.of(context).search,
              ),
            ),
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
