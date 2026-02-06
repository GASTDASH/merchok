import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/cart/cart.dart';
import 'package:merchok/features/category/category.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/generated/l10n.dart';

class MerchCard extends StatelessWidget {
  const MerchCard({
    super.key,
    required this.merch,
    this.count = 0,
    this.editable = true,
    this.onLongPress,
    this.onTapDelete,
    this.remainder,
  });

  final int count;
  final bool editable;
  final Merch merch;
  final VoidCallback? onLongPress;
  final VoidCallback? onTapDelete;
  final int? remainder;

  Future<void> editName(BuildContext context) async {
    final defaultName = S.of(context).untitled;

    String? newName = await showEditDialog(
      context: context,
      previous: merch.name,
      hintText: S.of(context).enterName,
    );
    if (newName == null) return;
    if (newName == '') newName = defaultName;

    if (!context.mounted) return;

    await _handleMerchEdit(
      context,
      updatedMerch: merch.copyWith(name: newName),
    );
  }

  Future<void> editPrices(BuildContext context) async {
    final newValues = await showChangePriceBottomSheet(context);
    if (newValues == null) return;

    final double newPrice = newValues['price']!;
    final double? newPurchasePrice = newValues['purchasePrice'];

    if (!context.mounted) return;

    await _handleMerchEdit(
      context,
      updatedMerch: merch.copyWith(
        price: newPrice,
        purchasePrice: newPurchasePrice,
      ),
    );
  }

  Future<void> changeCategory(BuildContext context) async {
    final merchBloc = context.read<MerchBloc>();
    final categoryState = context.read<CategoryBloc>().state;
    if (merch.categoryId != null && categoryState is! CategoryLoaded) {
      return;
    }
    categoryState as CategoryLoaded;

    final category = await showCategoriesBottomSheet(
      context,
      categoryState.categoryList.firstWhereOrNull(
        (c) => c.id == merch.categoryId,
      ),
    );
    if (category == null) return;
    if (category.isEmpty) {
      merchBloc.add(MerchEdit(merch: merch.copyWith(categoryId: null)));
    } else {
      merchBloc.add(MerchEdit(merch: merch.copyWith(categoryId: category.id)));
    }
  }

  Future<Map<String, double?>?> showChangePriceBottomSheet(
    BuildContext context,
  ) async => await showModalBottomSheet(
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    context: context,
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: ChangePriceBottomSheet(
        previousPrice: merch.price,
        previousPurchasePrice: merch.purchasePrice,
      ),
    ),
  );

  Future<dynamic> showBarcodeBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => BarcodeBottomSheet(merch: merch),
    );
  }

  void _editMerch(BuildContext context, {required Merch updatedMerch}) =>
      context.read<MerchBloc>().add(MerchEdit(merch: updatedMerch));

  Future<void> _handleMerchEdit(
    BuildContext context, {
    required Merch updatedMerch,
  }) async {
    final theme = Theme.of(context);
    final orderBloc = context.read<OrderBloc>();

    final orderState = orderBloc.state;
    if (orderState is! OrderLoaded) {
      _editMerch(context, updatedMerch: updatedMerch);
      return;
    }

    final ordersCount = orderState.orderList
        .where(
          (order) => order.orderItems.any((item) => item.merch.id == merch.id),
        )
        .length;

    log(ordersCount.toString());

    if (ordersCount == 0) {
      _editMerch(context, updatedMerch: updatedMerch);
      return;
    }

    await showYesNoDialog(
      context: context,
      customTitle: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).updateInReceipts,
            style: theme.textTheme.titleLarge,
          ),
          Text(S.of(context).updateInReceiptsDescription(ordersCount)),
        ],
      ),
      onYes: () {
        _editMerch(context, updatedMerch: updatedMerch);
        orderBloc.add(OrderUpdateAllMerch(updatedMerch: updatedMerch));
        context.pop();
      },
      onNo: () {
        _editMerch(context, updatedMerch: updatedMerch);
        context.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseContainer(
      onLongPress: onLongPress,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(24),
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
                        child: const Icon(AppIcons.edit, size: 16),
                      ),
                  ],
                ),
              ),
              if (onTapDelete != null)
                GestureDetector(
                  onTap: onTapDelete,
                  child: const Icon(AppIcons.delete),
                )
              else
                Row(
                  spacing: 16,
                  children: [
                    GestureDetector(
                      onTap: () => showBarcodeBottomSheet(context),
                      child: const Icon(Icons.qr_code_rounded),
                    ),
                    GestureDetector(
                      onTap: () async => await changeCategory(context),
                      child: Badge(
                        isLabelVisible: merch.categoryId != null,
                        child: const Icon(AppIcons.tag),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Row(
            spacing: 24,
            children: [
              _ImageBox(
                deletable: merch.image != null,
                editable: editable,
                image: merch.image,
                thumbnail: merch.thumbnail,
                onImageDeleted: () => context.read<MerchBloc>().add(
                  MerchEdit(
                    merch: merch.copyWith(image: null, thumbnail: null),
                  ),
                ),
                onImagePicked: (image) => context.read<MerchBloc>().add(
                  MerchUpdateImage(merch: merch, image: image),
                ),
              ),
              DescriptionSection(
                description: merch.description,
                onTapOutside: (text) {
                  if (merch.description == text) return;
                  context.read<MerchBloc>().add(
                    MerchEdit(merch: merch.copyWith(description: text)),
                  );
                },
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              (remainder != null) ? 'Осталось: $remainder' : 'Не привезено',
            ),
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
                      child: const Icon(AppIcons.edit, size: 16),
                    ),
                ],
              ),
              _CartManager(
                merch: merch,
                count: count,
                remainder: remainder ?? 0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CartManager extends StatelessWidget {
  const _CartManager({
    required this.merch,
    required this.count,
    required this.remainder,
  });

  final int count;
  final Merch merch;
  final int remainder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return count == 0
        ? Tooltip(
            message: 'Товара нет в запасе',
            triggerMode: TooltipTriggerMode.tap,
            child: BaseButton(
              // key: ValueKey('cart'),
              onTap: remainder != 0
                  ? () =>
                        context.read<CartBloc>().add(CartAdd(merchId: merch.id))
                  : null,
              padding: const EdgeInsets.all(12),
              child: const Icon(AppIcons.shoppingCart, color: Colors.white),
            ),
          )
        : Row(
            // key: ValueKey('plus_minus'),
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseButton(
                onTap: () =>
                    context.read<CartBloc>().add(CartMinus(merchId: merch.id)),
                constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                borderRadius: BorderRadius.circular(100),
                color: theme.disabledColor,
                child: const Icon(AppIcons.remove, color: Colors.white),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 50),
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
                onTap: count < remainder
                    ? () => context.read<CartBloc>().add(
                        CartPlus(merchId: merch.id),
                      )
                    : null,
                constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                borderRadius: BorderRadius.circular(100),
                child: const Icon(AppIcons.add, color: Colors.white),
              ),
            ],
          );
  }
}

class _ImageBox extends StatelessWidget {
  const _ImageBox({
    required this.deletable,
    required this.editable,
    this.image,
    this.thumbnail,
    required this.onImageDeleted,
    required this.onImagePicked,
  });

  final bool deletable;
  final bool editable;
  final Uint8List? image;
  final void Function() onImageDeleted;
  final void Function(Uint8List image) onImagePicked;
  final Uint8List? thumbnail;

  Widget? buildImage() {
    final Uint8List? imageToShow = thumbnail ?? image;

    if (imageToShow == null) return null;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.memory(
        imageToShow,
        fit: BoxFit.cover,
        cacheWidth: 150,
        cacheHeight: 150,
        errorBuilder: (context, error, st) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).disabledColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.broken_image, size: 32),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 105,
      width: 105,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: theme.disabledColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: buildImage(),
          ),
          if (editable)
            Align(
              alignment: AlignmentGeometry.topRight,
              child: _ImageIconButton(
                onTap: () async {
                  final pickedImage = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  if (pickedImage == null) return;
                  onImagePicked(await File(pickedImage.path).readAsBytes());
                },
                icon: AppIcons.edit,
              ),
            ),
          if (deletable)
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: _ImageIconButton(
                onTap: onImageDeleted,
                icon: AppIcons.delete,
              ),
            ),
        ],
      ),
    );
  }
}

class _ImageIconButton extends StatelessWidget {
  const _ImageIconButton({required this.onTap, required this.icon});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Theme.of(context).primaryColor,
          border: Border.all(color: Colors.white),
        ),
        padding: const EdgeInsets.all(4),
        child: FittedBox(child: Icon(icon, color: Colors.white)),
      ),
    );
  }
}
