import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.child,
    this.constraints = const BoxConstraints(),
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.onTap,
    this.color,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.inkWellAnimation = false,
  }) : _outlined = false,
       backgroundColor = null;

  const BaseButton.outlined({
    super.key,
    required this.child,
    this.constraints = const BoxConstraints(),
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.onTap,
    this.color,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.inkWellAnimation = false,
  }) : _outlined = true;

  final Color? backgroundColor;
  final BorderRadius borderRadius;
  final Widget child;
  final Color? color;
  final BoxConstraints constraints;
  final bool inkWellAnimation;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  final bool _outlined;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final boxDecoration = BoxDecoration(
      color: _outlined
          ? backgroundColor ?? Colors.transparent
          : onTap == null
          ? theme.disabledColor
          : color ?? theme.primaryColor,
      borderRadius: borderRadius,
      border: _outlined ? Border.all(color: color ?? theme.primaryColor) : null,
    );

    return ConstrainedBox(
      constraints: constraints,
      child: inkWellAnimation
          ? InkWell(
              onTap: onTap,
              splashColor: _outlined
                  ? null
                  : Colors.white.withValues(alpha: 0.3),
              borderRadius: borderRadius,
              child: Ink(
                padding: padding,
                decoration: boxDecoration,
                child: _BaseButtonContent(outlined: _outlined, child: child),
              ),
            )
          : GestureDetector(
              onTap: onTap,
              child: Container(
                padding: padding,
                decoration: boxDecoration,
                child: _BaseButtonContent(outlined: _outlined, child: child),
              ),
            ),
    );
  }
}

class _BaseButtonContent extends StatelessWidget {
  const _BaseButtonContent({required this.outlined, required this.child});

  final Widget child;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style:
                theme.textTheme.bodyMedium?.copyWith(
                  color: outlined ? theme.colorScheme.onSurface : Colors.white,
                  fontWeight: FontWeight.w500,
                ) ??
                TextStyle(),
            child: child,
          ),
        ],
      ),
    );
  }
}
