import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 128),
        child: Column(
          spacing: 24,
          children: [
            Expanded(
              child: BaseContainer(
                onTap: () {},
                child: Center(
                  child: Text(
                    S.of(context).cash,
                    style: theme.textTheme.displaySmall,
                  ),
                ),
              ),
            ),
            Expanded(
              child: BaseContainer(
                onTap: () {},
                child: Center(
                  child: Text(
                    S.of(context).transfer,
                    style: theme.textTheme.displaySmall,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
