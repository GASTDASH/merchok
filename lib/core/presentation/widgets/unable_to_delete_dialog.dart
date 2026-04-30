import 'package:flutter/material.dart';

class UnableToDeleteDialog extends StatelessWidget {
  const UnableToDeleteDialog({
    super.key,
    required this.icon,
    required this.message,
    this.textStyle,
  });

  final Widget icon;
  final String message;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            Text(
              message,
              style: textStyle ?? Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showUnableToDeleteDialog({
  required BuildContext context,
  required Widget icon,
  required String message,
  TextStyle? textStyle,
}) async => await showDialog(
  context: context,
  builder: (context) =>
      UnableToDeleteDialog(icon: icon, message: message, textStyle: textStyle),
);
