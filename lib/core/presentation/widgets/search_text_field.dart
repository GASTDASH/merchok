import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class SearchTextField<T extends Object> extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    required this.displayStringForOption,
    this.onChanged,
    required this.options,
    required this.optionsBuilder,
    required this.focusNode,
  });

  final TextEditingController controller;
  final AutocompleteOptionToString<T> displayStringForOption;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;
  final Iterable<T> options;
  final AutocompleteOptionsBuilder<T> optionsBuilder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.hintColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Autocomplete<T>(
              textEditingController: controller,
              onSelected: (option) {
                controller.text = displayStringForOption(option);
                focusNode.unfocus();
              },
              focusNode: focusNode,
              optionsBuilder: optionsBuilder,
              optionsViewBuilder: (context, onSelected, options) =>
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    separatorBuilder: (context, index) => Divider(height: 0),
                    itemBuilder: (BuildContext context, int index) {
                      final T option = options.elementAt(index);
                      return Material(
                        elevation: 4,
                        child: InkWell(
                          onTap: () => onSelected(option),
                          child: Ink(
                            color: Colors.white,
                            padding: const EdgeInsets.all(16.0),
                            child: Text(displayStringForOption(option)),
                          ),
                        ),
                      );
                    },
                  ),
              fieldViewBuilder:
                  (
                    context,
                    textEditingController,
                    focusNode,
                    onFieldSubmitted,
                  ) => TextField(
                    onTapOutside: (_) => focusNode.unfocus(),
                    focusNode: focusNode,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: S.of(context).search,
                    ),
                  ),
            ),
          ),
          BaseSvgIcon(context, IconNames.search),
        ],
      ),
    );
  }
}
