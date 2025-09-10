import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/core/presentation/widgets/edit_dialog.dart';
import 'package:merchok/features/category/categories.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/generated/l10n.dart';

class MerchCard extends StatelessWidget {
  const MerchCard({
    super.key,
    required this.merch,
    this.count = 0,
    this.showDelete = false,
    this.editable = true,
  });

  final Merch merch;
  final int count;
  final bool showDelete;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseContainer(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => DeleteDialog(
            message: 'Вы хотите удалить этот мерч?',
            onYes: () {
              context.pop();
              context.read<MerchBloc>().add(MerchDelete(merchId: merch.id));
            },
            onNo: () => context.pop(),
          ),
        );
      },
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
              ),
              showDelete
                  ? GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        IconNames.delete,
                        colorFilter: ColorFilter.mode(
                          theme.colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () => showCategoriesBottomSheet(context),
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
                    '${merch.price.truncate()} ₽',
                    style: theme.textTheme.headlineSmall,
                  ),
                  if (editable)
                    GestureDetector(
                      onTap: () async => await editPrices(context),
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
                        Text('$count', style: theme.textTheme.headlineSmall),
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

  Future<void> editName(BuildContext context) async {
    final bloc = context.read<MerchBloc>();

    String? newName = await showEditDialog(
      context: context,
      previous: merch.name,
      hintText: S.of(context).enterName,
    );
    if (newName == null) return;
    if (newName == '') newName = 'Без названия';

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

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.message,
    required this.onYes,
    required this.onNo,
  });

  final String message;
  final VoidCallback onYes;
  final VoidCallback onNo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Center(
              child: Text(
                message,
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 48,
              child: Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: BaseButton(onTap: onYes, child: Text('Да')),
                  ),
                  Expanded(
                    child: BaseButton.outlined(
                      onTap: onNo,
                      color: theme.colorScheme.onSurface,
                      child: Text('Нет'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
