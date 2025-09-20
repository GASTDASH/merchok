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
  }) : _outlined = true;

  final Color? backgroundColor;
  final BorderRadius borderRadius;
  final Widget child;
  final Color? color;
  final BoxConstraints constraints;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  final bool _outlined;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: constraints,
      child: Material(
        color: _outlined ? Colors.transparent : null,
        borderRadius: borderRadius,
        child: InkWell(
          splashColor: _outlined ? null : Colors.white.withValues(alpha: 0.3),
          onTap: onTap,
          borderRadius: borderRadius,
          child: Ink(
            decoration: BoxDecoration(
              color: _outlined
                  ? backgroundColor ?? Colors.transparent
                  : onTap == null
                  ? theme.disabledColor
                  : color ?? theme.primaryColor,
              borderRadius: borderRadius,
              border: _outlined
                  ? Border.all(color: color ?? theme.primaryColor)
                  : null,
            ),
            child: Padding(
              padding: padding,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultTextStyle(
                      style:
                          theme.textTheme.bodyMedium?.copyWith(
                            color: _outlined
                                ? theme.colorScheme.onSurface
                                : Colors.white,
                            fontWeight: FontWeight.w500,
                          ) ??
                          TextStyle(),
                      child: child,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
