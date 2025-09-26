import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/cart/cart.dart';
import 'package:merchok/features/category/category.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/generated/l10n.dart';

class MerchCard extends StatefulWidget {
  const MerchCard({
    super.key,
    required this.merch,
    this.count = 0,
    this.editable = true,
    this.onLongPress,
    this.onTapDelete,
  });

  final int count;
  final bool editable;
  final Merch merch;
  final VoidCallback? onLongPress;
  final VoidCallback? onTapDelete;

  @override
  State<MerchCard> createState() => _MerchCardState();
}

class _MerchCardState extends State<MerchCard> {
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.merch.description != null)
      descriptionController.text = widget.merch.description!;
  }

  Future<void> editName(BuildContext context) async {
    final defaultName = S.of(context).untitled;
    final bloc = context.read<MerchBloc>();

    String? newName = await showEditDialog(
      context: context,
      previous: widget.merch.name,
      hintText: S.of(context).enterName,
    );
    if (newName == null) return;
    if (newName == '') newName = defaultName;

    bloc.add(MerchEdit(merch: widget.merch.copyWith(name: newName)));
  }

  Future<void> editPrices(BuildContext context) async {
    final bloc = context.read<MerchBloc>();
    final newValues = await showChangePriceBottomSheet(context);
    if (newValues == null) return;

    final double newPrice = newValues['price']!;
    final double? newPurchasePrice = newValues['purchasePrice'];

    bloc.add(
      MerchEdit(
        merch: widget.merch.copyWith(
          price: newPrice,
          purchasePrice: newPurchasePrice,
        ),
      ),
    );
  }

  Future<void> changeCategory(BuildContext context) async {
    final merchBloc = context.read<MerchBloc>();
    final categoryState = context.read<CategoryBloc>().state;
    if (widget.merch.categoryId != null && categoryState is! CategoryLoaded) {
      return;
    }
    categoryState as CategoryLoaded;

    final category = await showCategoriesBottomSheet(
      context,
      categoryState.categoryList.firstWhereOrNull(
        (c) => c.id == widget.merch.categoryId,
      ),
    );
    if (category == null) return;
    if (category.isEmpty) {
      merchBloc.add(MerchEdit(merch: widget.merch.copyWith(categoryId: null)));
    } else {
      merchBloc.add(
        MerchEdit(merch: widget.merch.copyWith(categoryId: category.id)),
      );
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
        previousPrice: widget.merch.price,
        previousPurchasePrice: widget.merch.purchasePrice,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseContainer(
      onLongPress: widget.onLongPress,
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
                        widget.merch.name,
                        // ?? S.of(context).merchDefaultName,
                        style: theme.textTheme.bodyLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (widget.editable)
                      GestureDetector(
                        onTap: () async => await editName(context),
                        child: Icon(AppIcons.edit, size: 16),
                      ),
                  ],
                ),
              ),
              widget.onTapDelete != null
                  ? GestureDetector(
                      onTap: widget.onTapDelete,
                      child: Icon(AppIcons.delete),
                    )
                  : GestureDetector(
                      onTap: () async => await changeCategory(context),
                      child: Badge(
                        isLabelVisible: widget.merch.categoryId != null,
                        child: Icon(AppIcons.tag),
                      ),
                    ),
            ],
          ),
          Row(
            spacing: 24,
            children: [
              _ImageBox(
                deletable: widget.merch.image != null,
                editable: widget.editable,
                image: widget.merch.image,
                thumbnail: widget.merch.thumbnail,
                onImageDeleted: () => context.read<MerchBloc>().add(
                  MerchEdit(
                    merch: widget.merch.copyWith(image: null, thumbnail: null),
                  ),
                ),
                onImagePicked: (image) => context.read<MerchBloc>().add(
                  MerchUpdateImage(merch: widget.merch, image: image),
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
                  child: DescriptionTextField(
                    controller: descriptionController,
                    onTapOutside: (_) => context.read<MerchBloc>().add(
                      MerchEdit(
                        merch: widget.merch.copyWith(
                          description: descriptionController.text,
                        ),
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
                    '${widget.merch.price.truncateIfInt()} ₽',
                    style: theme.textTheme.headlineSmall,
                  ),
                  if (widget.editable)
                    GestureDetector(
                      onTap: () async => await editPrices(context),
                      child: Icon(AppIcons.edit, size: 16),
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
                child: widget.count == 0
                    ? BaseButton(
                        key: ValueKey('cart'),
                        onTap: () => context.read<CartBloc>().add(
                          CartAdd(merchId: widget.merch.id),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(AppIcons.shoppingCart, color: Colors.white),
                      )
                    : Row(
                        key: ValueKey('plus_minus'),
                        spacing: 8,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseButton(
                            onTap: () => context.read<CartBloc>().add(
                              CartMinus(merchId: widget.merch.id),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 48,
                              minHeight: 48,
                            ),
                            borderRadius: BorderRadius.circular(100),
                            color: theme.disabledColor,
                            child: Icon(AppIcons.remove, color: Colors.white),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(minWidth: 50),
                            child: AnimatedSwitcher(
                              duration: Durations.short3,
                              child: Text(
                                key: ValueKey(widget.count),
                                '${widget.count}',
                                style: theme.textTheme.headlineSmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          BaseButton(
                            onTap: () => context.read<CartBloc>().add(
                              CartPlus(merchId: widget.merch.id),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 48,
                              minHeight: 48,
                            ),
                            borderRadius: BorderRadius.circular(100),
                            child: Icon(AppIcons.add, color: Colors.white),
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
          child: Icon(Icons.broken_image, size: 32),
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
            margin: EdgeInsets.all(5),
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
        padding: EdgeInsets.all(4),
        child: FittedBox(child: Icon(icon, color: Colors.white)),
      ),
    );
  }
}
