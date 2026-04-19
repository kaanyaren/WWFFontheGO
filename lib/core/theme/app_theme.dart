import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Soft Green, White, and Earthy tones
  static const primaryColor = Color(0xFF2E8B57); // Sea Green
  static const secondaryColor = Color(0xFF8FBC8F); // Dark Sea Green
  static const scaffoldBackgroundColor = Color(0xFFF4F9F4); // Very soft green/white
  static const cardColor = Colors.white;
  static const accentColor = Color(0xFFFF8C00); // Dark Orange for accents/alerts
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: cardColor,
        tertiary: accentColor,
      ),
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      textTheme: GoogleFonts.geistTextTheme().copyWith(
        displayLarge: GoogleFonts.geist(fontWeight: FontWeight.bold, color: Colors.black87),
        displayMedium: GoogleFonts.geist(fontWeight: FontWeight.w600, color: Colors.black87),
        bodyLarge: GoogleFonts.geist(fontWeight: FontWeight.normal, color: Colors.black87),
        bodyMedium: GoogleFonts.geist(fontWeight: FontWeight.normal, color: Colors.black87),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.geist(
          color: primaryColor, 
          fontSize: 20, 
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      cardTheme: CardThemeData(
        color: cardColor.withOpacity(0.85),
        elevation: 4,
        shadowColor: secondaryColor.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.geist(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: secondaryColor.withOpacity(0.3), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
