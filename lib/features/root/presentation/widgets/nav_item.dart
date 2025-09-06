import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.selected,
    required this.icon,
    required this.onTap,
  });

  final bool selected;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<Color?>(
        duration: const Duration(milliseconds: 200),
        tween: ColorTween(
          begin: selected ? theme.hintColor : theme.primaryColor,
          end: selected ? theme.primaryColor : theme.hintColor,
        ),
        builder: (context, color, child) {
          return ColorFiltered(
            colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
            child: SvgPicture.asset(icon, height: 32),
          );
        },
      ),
    );
  }
}
