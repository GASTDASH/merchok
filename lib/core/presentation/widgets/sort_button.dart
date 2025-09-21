import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class SortButton extends StatelessWidget {
  const SortButton({super.key, required this.onTap, required this.icons});

  final VoidCallback onTap;
  final List<String> icons;

  @override
  Widget build(BuildContext context) {
    assert(icons.isNotEmpty);
    return Row(
      children: [
        BaseButton.outlined(
          onTap: onTap,
          color: Theme.of(context).colorScheme.onSurface,
          child: Row(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(S.of(context).sorting),
              ...icons.map((icon) => BaseSvgIcon(context, icon)),
            ],
          ),
        ),
      ],
    );
  }
}
