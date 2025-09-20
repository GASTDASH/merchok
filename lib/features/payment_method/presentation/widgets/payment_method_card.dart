import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/payment_method/payment_method.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    super.key,
    required this.paymentMethod,
    this.onTapEdit,
    this.onLongPress,
  });

  final VoidCallback? onLongPress;
  final VoidCallback? onTapEdit;
  final PaymentMethod paymentMethod;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseContainer(
      onLongPress: onLongPress,
      margin: EdgeInsets.symmetric(vertical: 12),
      padding: EdgeInsets.all(24),
      elevation: 8,
      child: Row(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    Text(
                      paymentMethod.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (paymentMethod.iconPath != null)
                      SvgPicture.asset(paymentMethod.iconPath!, height: 32),
                  ],
                ),
                Text(
                  paymentMethod.information,
                  style: theme.textTheme.headlineSmall,
                ),
                if (paymentMethod.description != null)
                  Text(
                    paymentMethod.description!,
                    style: theme.textTheme.bodyLarge,
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTapEdit,
            child: BaseSvgIcon(context, IconNames.edit),
          ),
        ],
      ),
    );
  }
}
