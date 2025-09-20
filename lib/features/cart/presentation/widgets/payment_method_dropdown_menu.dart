import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/features/payment_method/payment_method.dart';
import 'package:merchok/generated/l10n.dart';

class PaymentMethodDropdownMenu extends StatelessWidget {
  const PaymentMethodDropdownMenu({
    super.key,
    required this.paymentMethodList,
    this.selectedPaymentMethod,
    required this.onSelected,
  });

  final void Function(PaymentMethod? paymentMethod) onSelected;
  final List<PaymentMethod> paymentMethodList;
  final PaymentMethod? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: double.infinity,
      leadingIcon:
          selectedPaymentMethod != null &&
              selectedPaymentMethod?.iconPath != null
          ? Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                selectedPaymentMethod!.iconPath!,
                height: 32,
              ),
            )
          : null,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      hintText: S.of(context).selectPaymentMethod,
      onSelected: onSelected,
      dropdownMenuEntries: List.generate(paymentMethodList.length, (i) {
        final paymentMethod = paymentMethodList[i];
        return DropdownMenuEntry(
          leadingIcon: paymentMethod.iconPath != null
              ? SvgPicture.asset(paymentMethod.iconPath!, height: 32)
              : null,
          value: paymentMethod,
          label: paymentMethod.name,
        );
      }),
    );
  }
}
