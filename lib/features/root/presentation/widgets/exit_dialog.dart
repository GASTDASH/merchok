import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

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
            BaseSvgIcon(context, IconNames.logout, height: 48),
            Text(S.of(context).exitTheApp, style: theme.textTheme.titleLarge),
            SizedBox(
              height: 48,
              child: Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: BaseButton(
                      onTap: () => SystemNavigator.pop(),
                      child: Text(S.of(context).yes),
                    ),
                  ),
                  Expanded(
                    child: BaseButton.outlined(
                      onTap: () => context.pop(),
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
