import 'package:flutter/material.dart';
import 'app_colors.dart';

/// A full-screen gradient background that makes glass cards pop.
/// Includes subtle decorative circles for depth.
class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final colors = AppColors.gradientColors(brightness);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Decorative orb — top right
          Positioned(
            top: -60,
            right: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryGreen.withOpacity(
                  brightness == Brightness.dark ? 0.06 : 0.08,
                ),
              ),
            ),
          ),
          // Decorative orb — bottom left
          Positioned(
            bottom: -80,
            left: -60,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondaryGreen.withOpacity(
                  brightness == Brightness.dark ? 0.04 : 0.06,
                ),
              ),
            ),
          ),
          // Actual content
          child,
        ],
      ),
    );
  }
}
