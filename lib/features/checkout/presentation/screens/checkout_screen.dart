import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';

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
                  child: Text('Наличными', style: theme.textTheme.displaySmall),
                ),
              ),
            ),
            Expanded(
              child: BaseContainer(
                onTap: () {
                  context.push('/checkout/payment_methods');
                },
                child: Center(
                  child: Text('Переводом', style: theme.textTheme.displaySmall),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
