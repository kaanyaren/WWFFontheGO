import 'package:flutter/material.dart';

/// Centralized color system for light and dark themes.
class AppColors {
  AppColors._();

  // ─── Brand Colors (shared) ───────────────────────────────────
  static const primaryGreen = Color(0xFF2E8B57);
  static const secondaryGreen = Color(0xFF8FBC8F);
  static const accentOrange = Color(0xFFFF8C00);

  // ─── Light Theme ─────────────────────────────────────────────
  static const lightScaffold = Color(0xFFF4F9F4);
  static const lightSurface = Colors.white;
  static const lightOnSurface = Color(0xFF1A1A1A);
  static const lightSubtext = Color(0xFF607D8B); // blueGrey
  static const lightDivider = Color(0xFFE0E8E0);

  // Light glass
  static Color lightGlassFill = Colors.white.withOpacity(0.65);
  static Color lightGlassBorder = Colors.white.withOpacity(0.4);
  static Color lightGlassShadow = primaryGreen.withOpacity(0.08);

  // Light gradient stops
  static const lightGradientTop = Color(0xFFE8F5E9);
  static const lightGradientMid = Color(0xFFF4F9F4);
  static const lightGradientBottom = Color(0xFFE0F2F1);

  // ─── Dark Theme ──────────────────────────────────────────────
  static const darkScaffold = Color(0xFF0D1F17);
  static const darkSurface = Color(0xFF142820);
  static const darkOnSurface = Color(0xFFE8F5E9);
  static const darkSubtext = Color(0xFF8FAF9F);
  static const darkDivider = Color(0xFF1E3A2E);

  // Dark glass
  static Color darkGlassFill = const Color(0xFF1A3A2A).withOpacity(0.55);
  static Color darkGlassBorder = const Color(0xFF2E8B57).withOpacity(0.2);
  static Color darkGlassShadow = Colors.black.withOpacity(0.3);

  // Dark gradient stops
  static const darkGradientTop = Color(0xFF0A1A12);
  static const darkGradientMid = Color(0xFF0D1F17);
  static const darkGradientBottom = Color(0xFF112418);

  // ─── Helpers ─────────────────────────────────────────────────
  static Color glassFill(Brightness brightness) =>
      brightness == Brightness.dark ? darkGlassFill : lightGlassFill;

  static Color glassBorder(Brightness brightness) =>
      brightness == Brightness.dark ? darkGlassBorder : lightGlassBorder;

  static Color glassShadow(Brightness brightness) =>
      brightness == Brightness.dark ? darkGlassShadow : lightGlassShadow;

  static Color subtext(Brightness brightness) =>
      brightness == Brightness.dark ? darkSubtext : lightSubtext;

  static List<Color> gradientColors(Brightness brightness) =>
      brightness == Brightness.dark
          ? [darkGradientTop, darkGradientMid, darkGradientBottom]
          : [lightGradientTop, lightGradientMid, lightGradientBottom];
}
