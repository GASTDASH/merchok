import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class SuccessfullySavedDialog extends StatelessWidget {
  const SuccessfullySavedDialog({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          spacing: 32,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).fileSuccessfullySaved,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).filePath,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(path),
              ],
            ),
            SizedBox(
              height: 48,
              child: BaseButton(
                onTap: () => context.pop(),
                child: Text(S.of(context).ok),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
