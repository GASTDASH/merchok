import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/cart/cart.dart';
import 'package:merchok/features/category/categories.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/generated/l10n.dart';

class MerchCard extends StatelessWidget {
  const MerchCard({
    super.key,
    required this.merch,
    this.count = 0,
    this.editable = true,
    this.onLongPress,
    this.onTapDelete,
  });

  final Merch merch;
  final int count;
  final bool editable;
  final VoidCallback? onLongPress;
  final VoidCallback? onTapDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseContainer(
      onLongPress: onLongPress,
      margin: EdgeInsets.symmetric(vertical: 12),
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 16,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    Flexible(
                      child: Text(
                        merch.name,
                        // ?? S.of(context).merchDefaultName,
                        style: theme.textTheme.bodyLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (editable)
                      GestureDetector(
                        onTap: () async => await editName(context),
                        child: BaseSvgIcon(context, IconNames.edit, height: 16),
                      ),
                  ],
                ),
              ),
              onTapDelete != null
                  ? GestureDetector(
                      onTap: onTapDelete,
                      child: BaseSvgIcon(context, IconNames.delete),
                    )
                  : GestureDetector(
                      onTap: () => showCategoriesBottomSheet(context),
                      child: BaseSvgIcon(context, IconNames.tag),
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
                    if (editable)
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
                    style: theme.textTheme.bodySmall,
                    controller: TextEditingController(text: merch.description),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: S.of(context).description,
                      hintStyle: theme.textTheme.bodySmall?.copyWith(
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
                  Text(
                    '${merch.price.truncateIfInt()} ₽',
                    style: theme.textTheme.headlineSmall,
                  ),
                  if (editable)
                    GestureDetector(
                      onTap: () async => await editPrices(context),
                      child: BaseSvgIcon(context, IconNames.edit, height: 16),
                    ),
                ],
              ),
              AnimatedSwitcher(
                duration: Durations.short3,
                layoutBuilder: (currentChild, previousChildren) => Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    if (currentChild != null) currentChild,
                    ...previousChildren,
                  ],
                ),
                child: count == 0
                    ? BaseButton(
                        key: ValueKey('cart'),
                        onTap: () => context.read<CartBloc>().add(
                          CartAdd(merchId: merch.id),
                        ),
                        padding: EdgeInsets.all(12),
                        child: SvgPicture.asset(IconNames.shoppingCart),
                      )
                    : Row(
                        key: ValueKey('plus_minus'),
                        spacing: 8,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseButton(
                            onTap: () => context.read<CartBloc>().add(
                              CartMinus(merchId: merch.id),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 48,
                              minHeight: 48,
                            ),
                            borderRadius: BorderRadius.circular(100),
                            color: theme.disabledColor,
                            child: SvgPicture.asset(IconNames.remove),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(minWidth: 50),
                            child: AnimatedSwitcher(
                              duration: Durations.short3,
                              child: Text(
                                key: ValueKey(count),
                                '$count',
                                style: theme.textTheme.headlineSmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          BaseButton(
                            onTap: () => context.read<CartBloc>().add(
                              CartPlus(merchId: merch.id),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 48,
                              minHeight: 48,
                            ),
                            borderRadius: BorderRadius.circular(100),
                            child: SvgPicture.asset(IconNames.add),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> editName(BuildContext context) async {
    final defaultName = S.of(context).untitled;
    final bloc = context.read<MerchBloc>();

    String? newName = await showEditDialog(
      context: context,
      previous: merch.name,
      hintText: S.of(context).enterName,
    );
    if (newName == null) return;
    if (newName == '') newName = defaultName;

    bloc.add(MerchEdit(merch: merch.copyWith(name: newName)));
  }

  Future<void> editPrices(BuildContext context) async {
    final bloc = context.read<MerchBloc>();
    final newValues = await showChangePriceBottomSheet(context);
    if (newValues == null) return;

    final double newPrice = newValues['price']!;
    final double? newPurchasePrice = newValues['purchasePrice'];

    bloc.add(
      MerchEdit(
        merch: merch.copyWith(price: newPrice, purchasePrice: newPurchasePrice),
      ),
    );
  }

  Future<Map<String, double?>?> showChangePriceBottomSheet(
    BuildContext context,
  ) async => await showModalBottomSheet(
    useRootNavigator: true,
    context: context,
    builder: (context) => ChangePriceBottomSheet(
      previousPrice: merch.price,
      previousPurchasePrice: merch.purchasePrice,
    ),
  );
}
