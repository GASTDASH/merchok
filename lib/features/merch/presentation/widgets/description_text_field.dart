import 'package:flutter/material.dart';
import 'package:merchok/generated/l10n.dart';

class DescriptionTextField extends StatefulWidget {
  const DescriptionTextField({
    super.key,
    required this.controller,
    this.onTapOutside,
  });

  final TextEditingController controller;
  final TapRegionCallback? onTapOutside;

  @override
  State<DescriptionTextField> createState() => _DescriptionTextFieldState();
}

class _DescriptionTextFieldState extends State<DescriptionTextField> {
  String? text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      onTap: () => text = widget.controller.text,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
        if (widget.onTapOutside != null && text != widget.controller.text) {
          widget.onTapOutside!(event);
        }
      },
      maxLines: null,
      keyboardType: TextInputType.multiline,
      style: theme.textTheme.bodySmall,
      controller: widget.controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: S.of(context).description,
        hintStyle: theme.textTheme.bodySmall?.copyWith(
          color: theme.disabledColor,
        ),
      ),
    );
  }
}
