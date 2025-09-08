import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList.builder(
              itemCount: 5,
              itemBuilder: (context, index) => BaseContainer(
                onTap: () {},
                margin: EdgeInsets.symmetric(vertical: 12),
                padding: EdgeInsets.all(24),
                child: Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 12,
                      children: [
                        Text(
                          'Сбербанк',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SvgPicture.asset(IconNames.alfabank, height: 32),
                      ],
                    ),
                    Text(
                      '+7 (916) 990 68-64',
                      style: theme.textTheme.headlineSmall,
                    ),
                    Text(
                      'Алексей Вадимович Щ.',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
