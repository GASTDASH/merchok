import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.selected,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkResponse(
      onTap: onTap,
      child: Container(
        height: 64,
        width: 64,
        padding: const EdgeInsets.all(16),
        child: TweenAnimationBuilder<Color?>(
          duration: const Duration(milliseconds: 200),
          tween: ColorTween(
            begin: selected ? theme.hintColor : theme.primaryColor,
            end: selected ? theme.primaryColor : theme.hintColor,
          ),
          builder: (context, color, child) {
            return ColorFiltered(
              colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
              child: Icon(icon, size: 32),
            );
          },
        ),
      ),
    );
  }
}
