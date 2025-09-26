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
    this.inkWellAnimation = false,
  });

  final Widget? child;
  final double elevation;
  final double? height;
  final bool inkWellAnimation;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final boxDecoration = BoxDecoration(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 8)),
      ],
    );

    if (inkWellAnimation) {
      return Padding(
        padding: margin ?? EdgeInsets.zero,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(24),
          child: Ink(
            height: height,
            width: width,
            padding: padding,
            decoration: boxDecoration,
            child: child,
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        margin: margin,
        decoration: boxDecoration,
        child: child,
      ),
    );
  }
}
