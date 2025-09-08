import 'package:flutter/material.dart';

class BaseSliverAppBar extends StatelessWidget {
  const BaseSliverAppBar({super.key, required this.title, this.actions});

  final List<Widget>? actions;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      pinned: true,
      elevation: 12,
      shadowColor: Colors.black26,
      backgroundColor: theme.scaffoldBackgroundColor,
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      actionsPadding: EdgeInsets.only(right: 8),
      actions: actions,
    );
  }
}
