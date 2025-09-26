import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class DescriptionSection extends StatefulWidget {
  const DescriptionSection({
    super.key,
    required this.description,
    required this.onTapOutside,
  });

  final String? description;
  final void Function(String? text) onTapOutside;

  @override
  State<DescriptionSection> createState() => _DescriptionSectionState();
}

class _DescriptionSectionState extends State<DescriptionSection> {
  final TextEditingController descriptionController = TextEditingController();
  bool editing = false;
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.description != null) {
      descriptionController.text = widget.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: editing
          ? _DescriptionContainer(
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      AppIcons.edit,
                      color: theme.disabledColor.withAlpha(150),
                      size: 32,
                    ),
                  ),
                  _DescriptionTextField(
                    focusNode: focusNode,
                    controller: descriptionController,
                    onTapOutside: (_) {
                      setState(() => editing = false);
                      widget.onTapOutside(
                        descriptionController.text != ''
                            ? descriptionController.text
                            : null,
                      );
                    },
                  ),
                ],
              ),
            )
          : GestureDetector(
              onTap: () {
                setState(() => editing = true);
                focusNode.requestFocus();
              },
              child: _DescriptionContainer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    widget.description ?? S.of(context).description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: widget.description == null
                          ? theme.hintColor
                          : null,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class _DescriptionContainer extends StatelessWidget {
  const _DescriptionContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.disabledColor),
      ),
      child: child,
    );
  }
}

class _DescriptionTextField extends StatelessWidget {
  const _DescriptionTextField({
    required this.controller,
    this.onTapOutside,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final TapRegionCallback? onTapOutside;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
        if (onTapOutside != null) {
          onTapOutside!(event);
        }
      },
      maxLines: null,
      keyboardType: TextInputType.multiline,
      style: theme.textTheme.bodySmall,
      controller: controller,
      focusNode: focusNode,
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
