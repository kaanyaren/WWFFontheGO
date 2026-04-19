import 'dart:ui';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double blur;
  final double? opacity;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const GlassCard({
    super.key,
    required this.child,
    this.blur = 12.0,
    this.opacity,
    this.padding,
    this.borderRadius = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final fillColor = opacity != null
        ? (brightness == Brightness.dark
            ? const Color(0xFF1A3A2A).withOpacity(opacity!)
            : Colors.white.withOpacity(opacity!))
        : AppColors.glassFill(brightness);
    final borderColor = AppColors.glassBorder(brightness);
    final shadowColor = AppColors.glassShadow(brightness);

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
