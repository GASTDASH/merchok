import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/generated/l10n.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseDraggableScrollableSheet(
      padding: EdgeInsets.zero,
      builder: (context, scrollController) => CustomScrollView(
        controller: scrollController,
        slivers: [
          false
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      spacing: 32,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          S.of(context).emptyCart,
                          style: theme.textTheme.headlineLarge,
                        ),
                        SvgPicture.asset(IconNames.cart, height: 64),
                      ],
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.all(24),
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).total,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '1800 ₽',
                              style: theme.textTheme.headlineLarge,
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 24)),
                      SliverToBoxAdapter(
                        child: BaseButton(
                          onTap: () {},
                          padding: EdgeInsetsGeometry.all(12),
                          child: Text(
                            S.of(context).checkout,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 24)),
                      SliverList.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) =>
                            MerchCard(showDelete: true),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
