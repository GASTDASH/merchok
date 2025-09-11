import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class ChangePriceBottomSheet extends StatefulWidget {
  const ChangePriceBottomSheet({
    super.key,
    required this.previousPrice,
    this.previousPurchasePrice,
  });

  final double previousPrice;
  final double? previousPurchasePrice;

  @override
  State<ChangePriceBottomSheet> createState() => _ChangePriceBottomSheetState();
}

class _ChangePriceBottomSheetState extends State<ChangePriceBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController purchasePriceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    priceController.text = widget.previousPrice.truncate().toString();
    purchasePriceController.text =
        (widget.previousPurchasePrice?.truncate() ?? '').toString();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 390,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Align(
              alignment: AlignmentGeometry.topRight,
              child: FittedBox(
                child: BaseButton(
                  onTap: () {
                    if (!formKey.currentState!.validate()) return;
                    context.pop({
                      'price': double.parse(priceController.text),
                      'purchasePrice': double.tryParse(
                        purchasePriceController.text,
                      ),
                    });
                  },
                  child: Text(S.of(context).save),
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(S.of(context).price, style: theme.textTheme.bodyLarge),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                changePriceButton(
                  onTap: () {},
                  text: S.of(context).minus100,
                  color: HSLColor.fromColor(
                    theme.primaryColor,
                  ).withLightness(0.42).toColor(),
                ),
                changePriceButton(
                  onTap: () {},
                  text: S.of(context).minus50,
                  color: theme.primaryColorDark,
                ),
                changePriceButton(
                  onTap: () {},
                  text: S.of(context).minus10,
                  color: theme.primaryColor,
                ),
                SizedBox(
                  width: 128,
                  child: TextFormField(
                    controller: priceController,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall,
                    decoration: InputDecoration(
                      hintText: '0 ₽',
                      hintStyle: TextStyle(color: theme.disabledColor),
                    ),
                    validator: (value) => double.tryParse(value!) != null
                        ? null
                        : S.of(context).enterCorrectNumber,
                  ),
                ),
                changePriceButton(
                  onTap: () {},
                  text: S.of(context).plus10,
                  color: theme.primaryColor,
                ),
                changePriceButton(
                  onTap: () {},
                  text: S.of(context).plus50,
                  color: theme.primaryColorDark,
                ),
                changePriceButton(
                  onTap: () {},
                  text: S.of(context).plus100,
                  color: HSLColor.fromColor(
                    theme.primaryColor,
                  ).withLightness(0.42).toColor(),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(S.of(context).purchasePrice, style: theme.textTheme.bodyLarge),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 128,
                  child: TextFormField(
                    controller: purchasePriceController,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall,
                    decoration: InputDecoration(
                      hintText: '0 ₽',
                      hintStyle: TextStyle(color: theme.disabledColor),
                    ),
                    validator: (value) =>
                        (value == '' || double.tryParse(value!) != null)
                        ? null
                        : S.of(context).enterCorrectNumber,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  BaseButton changePriceButton({
    required String text,
    VoidCallback? onTap,
    required Color color,
  }) {
    return BaseButton(
      onTap: onTap,
      constraints: BoxConstraints(minWidth: 38),
      padding: EdgeInsetsGeometry.all(4),
      color: color,
      child: Text(text),
    );
  }
}
