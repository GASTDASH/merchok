import 'package:flutter/material.dart';

class BaseContainer extends StatefulWidget {
  const BaseContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.padding,
    @Deprecated('Use boxShadow instead') this.elevation = 12,
    this.boxShadow,
    this.onTap,
    this.onLongPress,
    this.inkWellAnimation = false,
    this.foregroundDecoration,
  });

  final List<BoxShadow>? boxShadow;
  final Widget? child;
  final double elevation;
  final Decoration? foregroundDecoration;
  final double? height;
  final bool inkWellAnimation;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double? width;

  static const _defaultShadow = [
    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 8)),
  ];

  @override
  State<BaseContainer> createState() => _BaseContainerState();
}

class _BaseContainerState extends State<BaseContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Durations.medium1,
      reverseDuration: Durations.short1,
      vsync: this,
    );
    scaleAnimation = Tween<double>(
      begin: 1,
      end: 1.03,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final boxDecoration = BoxDecoration(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(24),
      boxShadow: widget.boxShadow ?? BaseContainer._defaultShadow,
    );

    if (widget.inkWellAnimation) {
      return Padding(
        padding: widget.margin ?? EdgeInsets.zero,
        child: InkWell(
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          borderRadius: BorderRadius.circular(24),
          child: Ink(
            height: widget.height,
            width: widget.width,
            padding: widget.padding,
            decoration: boxDecoration,
            child: widget.child,
          ),
        ),
      );
    }
    return AnimatedBuilder(
      animation: scaleAnimation,
      builder: (context, child) {
        return GestureDetector(
          onTap: widget.onTap,
          onTapDown: (_) => controller.forward(),
          onTapUp: (_) => controller.reverse(),
          onTapCancel: () => controller.reverse(),
          onLongPress: widget.onLongPress,
          child: Transform.scale(
            scale: scaleAnimation.value,
            child: Container(
              height: widget.height,
              width: widget.width,
              padding: widget.padding,
              margin: widget.margin,
              decoration: boxDecoration,
              foregroundDecoration: widget.foregroundDecoration,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
