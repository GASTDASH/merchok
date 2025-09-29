import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key, required this.controller, this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  bool hasText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).hintColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              onChanged: widget.onChanged,
              controller: widget.controller
                ..addListener(() {
                  if (widget.controller.text.isNotEmpty && !hasText) {
                    setState(() => hasText = true);
                  } else if (widget.controller.text.isEmpty && hasText) {
                    setState(() => hasText = false);
                  }
                }),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: S.of(context).search,
              ),
            ),
          ),
          hasText
              ? GestureDetector(
                  onTap: () => widget.controller.text = '',
                  child: const Icon(Icons.close_rounded),
                )
              : const Icon(AppIcons.search),
        ],
      ),
    );
  }
}
