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
  final VoidCallback onNo;
  final VoidCallback onYes;

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

Future<dynamic> showDeleteDialog({
  required BuildContext context,
  required String message,
  required VoidCallback onYes,
  required VoidCallback onNo,
}) async => await showDialog(
  context: context,
  builder: (context) =>
      DeleteDialog(message: message, onYes: onYes, onNo: onNo),
);
