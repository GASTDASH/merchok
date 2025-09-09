import 'package:flutter/material.dart';

class BaseDraggableScrollableSheet extends StatefulWidget {
  const BaseDraggableScrollableSheet({
    super.key,
    required this.builder,
    this.initialChildSize = 0.75,
    this.minChildSize = 0.4,
    this.maxChildSize = 1.0,
    this.padding = const EdgeInsets.all(16),
  });

  final ScrollableWidgetBuilder builder;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final EdgeInsetsGeometry padding;

  @override
  State<BaseDraggableScrollableSheet> createState() =>
      _BaseDraggableScrollableSheetState();
}

class _BaseDraggableScrollableSheetState
    extends State<BaseDraggableScrollableSheet> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        if (notification.extent == 1) {
          setState(() => expanded = true);
        } else if (expanded) {
          setState(() => expanded = false);
        }
        return true;
      },
      child: DraggableScrollableSheet(
        initialChildSize: widget.initialChildSize,
        minChildSize: widget.minChildSize,
        maxChildSize: widget.maxChildSize,
        builder: (context, scrollController) => Padding(
          padding: EdgeInsets.zero,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: widget.padding,
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: expanded
                  ? null
                  : BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: widget.builder(context, scrollController),
          ),
        ),
      ),
    );
  }
}

Future<T?> showBaseDraggableBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) => showModalBottomSheet(
  isScrollControlled: true,
  useRootNavigator: true,
  backgroundColor: Colors.transparent,
  context: context,
  builder: builder,
);
