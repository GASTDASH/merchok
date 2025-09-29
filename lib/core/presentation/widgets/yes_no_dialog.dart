import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class YesNoDialog extends StatelessWidget {
  const YesNoDialog({
    super.key,
    this.customTitle,
    this.message,
    required this.onYes,
    required this.onNo,
  }) : assert(customTitle == null || message == null),
       assert(customTitle != null || message != null);

  final Widget? customTitle;
  final String? message;
  final VoidCallback onNo;
  final VoidCallback onYes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            message != null
                ? Center(
                    child: Text(
                      message!,
                      style: theme.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  )
                : customTitle!,
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

Future<dynamic> showYesNoDialog({
  required BuildContext context,
  Widget? customTitle,
  String? message,
  required VoidCallback onYes,
  required VoidCallback onNo,
}) async => await showDialog(
  context: context,
  builder: (context) => YesNoDialog(
    customTitle: customTitle,
    message: message,
    onYes: onYes,
    onNo: onNo,
  ),
);
