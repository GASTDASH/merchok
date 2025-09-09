import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class OrderCreatedDialog extends StatelessWidget {
  const OrderCreatedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          spacing: 24,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).orderSuccessfullyCreated,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SvgPicture.asset(IconNames.success, height: 64),
            SizedBox(
              height: 48,
              child: Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: BaseButton.outlined(
                      onTap: () {
                        context.pop();
                        context.go('/orders');
                      },
                      color: theme.colorScheme.onSurface,
                      child: Expanded(
                        child: Center(
                          child: Text(
                            S.of(context).goToOrders,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  BaseButton(
                    onTap: () {
                      context.pop();
                    },
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                    child: Text(S.of(context).back),
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
