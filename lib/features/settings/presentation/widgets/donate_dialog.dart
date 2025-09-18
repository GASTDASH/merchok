import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class DonateDialog extends StatelessWidget {
  const DonateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Text(
              S.of(context).goToTheDonatePage,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 48,
              child: Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: BaseButton(
                      onTap: () async {
                        final goRouter = GoRouter.of(context);
                        final scaffoldMessenger = ScaffoldMessenger.of(context);
                        final s = S.of(context);

                        final uri = Uri.parse(
                          'https://pay.cloudtips.ru/p/705ff26b',
                        );

                        goRouter.pop(); // Close Donate Dialog
                        showLoadingDialog(
                          context: context,
                          message: s.openingPage,
                        );

                        final opened = await launchUrl(uri);
                        goRouter.pop(); // Close Loading Dialog

                        // Если не удалось открыть страницу
                        if (!opened) {
                          scaffoldMessenger.hideCurrentSnackBar();
                          scaffoldMessenger.showSnackBar(
                            SnackBar(
                              backgroundColor: theme.colorScheme.error,
                              content: Text(s.couldntOpenPage),
                            ),
                          );
                        }
                      },
                      child: Text(S.of(context).yes),
                    ),
                  ),
                  Expanded(
                    child: BaseButton.outlined(
                      onTap: () {
                        context.pop();
                      },
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
