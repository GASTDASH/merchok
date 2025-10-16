import 'package:flutter/material.dart';
import 'package:merchok/generated/l10n.dart';

// translate-me-ignore-all-file
class NotFoundDialog extends StatelessWidget {
  const NotFoundDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.qr_code_rounded, size: 48),
            Text(
              S.of(context).scannedMerchNotFound,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            Text(S.of(context).tryAgainOrNoMerch),
          ],
        ),
      ),
    );
  }
}
