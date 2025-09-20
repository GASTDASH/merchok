import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  const BaseContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.elevation = 12,
    this.onTap,
    this.onLongPress,
  });

  final Widget? child;
  final double elevation;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(24),
          child: Ink(
            height: height,
            width: width,
            padding: padding,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
