import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [Text(text), Icon(icon)],
        ),
      ),
    );
  }
}
