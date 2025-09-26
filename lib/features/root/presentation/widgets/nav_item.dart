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
        child: Icon(
          icon,
          size: 32,
          color: selected ? theme.primaryColor : theme.hintColor,
        ),
      ),
    );
  }
}
