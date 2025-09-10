import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.message,
    required this.onYes,
    required this.onNo,
  });

  final String message;
  final VoidCallback onYes;
  final VoidCallback onNo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Center(
              child: Text(
                message,
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 48,
              child: Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: BaseButton(
                      onTap: onYes,
                      child: Text(S.of(context).yes),
                    ),
                  ),
                  Expanded(
                    child: BaseButton.outlined(
                      onTap: onNo,
                      color: theme.colorScheme.onSurface,
                      child: Text(S.of(context).no),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
