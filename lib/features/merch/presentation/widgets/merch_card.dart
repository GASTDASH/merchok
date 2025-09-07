import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/generated/l10n.dart';

class MerchCard extends StatelessWidget {
  const MerchCard({super.key, this.count = 0});

  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseContainer(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).merchDefaultName,
                style: TextStyle(fontSize: 16),
              ),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  IconNames.tag,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: 24,
            children: [
              SizedBox(
                height: 105,
                width: 105,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5, top: 5),
                      decoration: BoxDecoration(
                        color: theme.disabledColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Align(
                      alignment: AlignmentGeometry.topRight,
                      child: Material(
                        borderRadius: BorderRadius.circular(24),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(24),
                          splashColor: Colors.white.withValues(alpha: 0.3),
                          child: Ink(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: theme.primaryColor,
                              border: Border.all(color: Colors.white),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: SvgPicture.asset(IconNames.edit),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.disabledColor),
                  ),
                  child: TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: S.of(context).description,
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: theme.disabledColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Text('150 ₽', style: TextStyle(fontSize: 24)),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        useRootNavigator: true,
                        context: context,
                        builder: (context) => ChangePriceBottomSheet(),
                      );
                    },
                    child: SvgPicture.asset(
                      IconNames.edit,
                      height: 16,
                      colorFilter: ColorFilter.mode(
                        theme.colorScheme.onSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
              count == 0
                  ? BaseButton(
                      onTap: () {},
                      padding: EdgeInsets.all(12),
                      child: SvgPicture.asset(IconNames.shoppingCart),
                    )
                  : Row(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BaseButton(
                          onTap: () {},
                          constraints: BoxConstraints(
                            minWidth: 48,
                            minHeight: 48,
                          ),
                          borderRadius: BorderRadius.circular(100),
                          color: theme.disabledColor,
                          child: SvgPicture.asset(IconNames.remove),
                        ),
                        Text('$count', style: TextStyle(fontSize: 24)),
                        BaseButton(
                          onTap: () {},
                          constraints: BoxConstraints(
                            minWidth: 48,
                            minHeight: 48,
                          ),
                          borderRadius: BorderRadius.circular(100),
                          child: SvgPicture.asset(IconNames.add),
                        ),
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
