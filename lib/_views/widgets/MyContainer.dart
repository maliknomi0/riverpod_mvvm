import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:provider/provider.dart';
import 'package:riverpordmvvm/_Controller/theme_Controller.dart';
import 'package:riverpordmvvm/themes/theme_constants.dart';

class MyContainer extends StatefulWidget {
  // Core properties
  final Widget child;
  final VoidCallback? onTap;
  final double? height, width;

  // Decoration properties
  final double radius;
  final Color outlineColor;
  final Color? backgroundColor;
  final bool hasGradient;
  final Gradient? customGradient;
  final bool hasShadow;
  final BoxShadow? customShadow;
  final bool hasBorder; // New parameter to enable border in light mode

  // Padding and Margin
  final double marginTop, marginBottom, marginLeft, marginRight;
  final double paddingTop, paddingBottom, paddingLeft, paddingRight;

  // Animation properties
  final bool hasBounce;
  final Duration? bounceDuration;
  final bool hasOpacityAnimation;
  final Duration? opacityDuration;

  // Border properties
  final double borderWidth;
  final BorderStyle borderStyle;

  // Alignment
  final AlignmentGeometry? alignment;

  const MyContainer({
    super.key,
    required this.child,
    this.onTap,
    this.height,
    this.width,
    this.radius = 0,
    this.outlineColor = Colors.grey,
    this.backgroundColor,
    this.hasGradient = false,
    this.customGradient,
    this.hasShadow = false,
    this.customShadow,
    this.hasBorder = false, // Default is false, must be enabled explicitly
    this.marginTop = 0,
    this.marginBottom = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    this.hasBounce = true,
    this.bounceDuration = const Duration(milliseconds: 100),
    this.hasOpacityAnimation = true,
    this.opacityDuration = const Duration(milliseconds: 500),
    this.borderWidth = 1.0,
    this.borderStyle = BorderStyle.solid,
    this.alignment,
  });

  @override
  _MyContainerState createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.hasOpacityAnimation) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            opacity = 1.0;
          });
        }
      });
    } else {
      opacity = 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeController>().themeMode;
    final systemIsDark = Theme.of(context).brightness == Brightness.dark;
    final isDarkMode = themeMode == ThemeMode.system
        ? systemIsDark
        : themeMode == ThemeMode.dark;

    // Default shadow if customShadow isn't provided
    final defaultShadow = BoxShadow(
      color: Colors.grey.withOpacity(0.3),
      spreadRadius: 2,
      blurRadius: 5,
      offset: const Offset(0, 3),
    );

    // Determine decoration based on mode
    Decoration getDecoration() {
      if (widget.hasGradient) {
        // Apply gradient in both dark and light modes if hasGradient is true
        return BoxDecoration(
          gradient: widget.customGradient ?? lightAppGradiant,
          borderRadius: BorderRadius.circular(widget.radius),
          boxShadow: widget.hasShadow
              ? [widget.customShadow ?? defaultShadow]
              : null,
        );
      } else if (isDarkMode) {
        // Dark mode without gradient
        return BoxDecoration(
          color: widget.backgroundColor ?? greyColor,
          borderRadius: BorderRadius.circular(widget.radius),
          boxShadow: widget.hasShadow
              ? [widget.customShadow ?? defaultShadow]
              : null,
        );
      } else {
        // Light mode without gradient
        return BoxDecoration(
          color: widget.backgroundColor ?? whiteColor,
          border: widget.hasBorder
              ? Border.all(
                  color: widget.outlineColor,
                  width: widget.borderWidth,
                  style: widget.borderStyle,
                )
              : null,
          borderRadius: BorderRadius.circular(widget.radius),
          boxShadow: widget.hasShadow
              ? [widget.customShadow ?? defaultShadow]
              : null,
        );
      }
    }

    Widget container = Container(
      margin: EdgeInsets.only(
        top: widget.marginTop,
        bottom: widget.marginBottom,
        left: widget.marginLeft,
        right: widget.marginRight,
      ),
      padding: EdgeInsets.only(
        top: widget.paddingTop,
        bottom: widget.paddingBottom,
        left: widget.paddingLeft,
        right: widget.paddingRight,
      ),
      height: widget.height,
      width: widget.width,
      alignment: widget.alignment,
      decoration: getDecoration(),
      child: Material(color: Colors.transparent, child: widget.child),
    );

    // Apply opacity animation if enabled
    container = widget.hasOpacityAnimation
        ? AnimatedOpacity(
            duration: widget.opacityDuration!,
            opacity: opacity,
            child: container,
          )
        : container;

    // Apply bounce effect if enabled and onTap is provided
    return widget.onTap != null && widget.hasBounce
        ? Bounce(
            duration: widget.bounceDuration!,
            onPressed: widget.onTap!,
            child: container,
          )
        : container;
  }
}
