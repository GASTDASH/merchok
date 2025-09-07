import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class ChangePriceBottomSheet extends StatelessWidget {
  const ChangePriceBottomSheet({super.key});

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
      child: Column(
        children: [
          Align(
            alignment: AlignmentGeometry.topRight,
            child: FittedBox(
              child: BaseButton(
                onTap: () {
                  context.pop();
                },
                child: Text(
                  S.of(context).save,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 32),
          Text(S.of(context).price, style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              changePriceButton(
                onTap: () {},
                text: '-100',
                color: HSLColor.fromColor(
                  theme.primaryColor,
                ).withLightness(0.42).toColor(),
              ),
              changePriceButton(
                onTap: () {},
                text: '-50',
                color: theme.primaryColorDark,
              ),
              changePriceButton(
                onTap: () {},
                text: '-10',
                color: theme.primaryColor,
              ),
              SizedBox(
                width: 128,
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    hintText: '0 ₽',
                    hintStyle: TextStyle(color: theme.disabledColor),
                  ),
                ),
              ),
              changePriceButton(
                onTap: () {},
                text: '+10',
                color: theme.primaryColor,
              ),
              changePriceButton(
                onTap: () {},
                text: '+50',
                color: theme.primaryColorDark,
              ),
              changePriceButton(
                onTap: () {},
                text: '+100',
                color: HSLColor.fromColor(
                  theme.primaryColor,
                ).withLightness(0.42).toColor(),
              ),
            ],
          ),
          SizedBox(height: 24),
          Text(S.of(context).purchasePrice, style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 128,
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    hintText: '0 ₽',
                    hintStyle: TextStyle(color: theme.disabledColor),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
        ],
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
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
