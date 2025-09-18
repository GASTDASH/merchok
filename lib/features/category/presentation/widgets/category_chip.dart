import 'package:flutter/material.dart';
import 'package:merchok/features/category/category.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.category,
    required this.selected,
    this.onSelected,
    this.onLongPress,
  });

  final Category category;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final GestureLongPressCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: ChoiceChip(
        label: Text(category.name),
        selected: selected,
        onSelected: onSelected,
      ),
    );
  }
}
