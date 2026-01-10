import 'dart:ui';
import 'package:flutter/material.dart';

/// A container that applies a blur effect (glassmorphism) to its background.
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double blurAmount;
  final Color backgroundColor;
  final double borderRadius;

  const GlassContainer({
    super.key,
    required this.child,
    this.height,
    this.padding,
    this.blurAmount = 15.0,
    this.backgroundColor = const Color(0xA61E1E1E), // 0xA6 is ~65% opacity
    this.borderRadius = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: Container(
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withOpacity(0.08), 
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
