import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF1F1F1F);
  static const Color secondaryColor = Color(0xFF2D2D2D);
  static const Color accentColor = Color(0xFFFF6B35);
  static const Color accentColorLight = Color(0xFFFF8C42);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFE74C3C);
  static const Color warningColor = Color(0xFFFFA500);
  static const Color infoColor = Color(0xFF3498DB);
  
  // Text Colors
  static const Color textPrimaryColor = Color(0xFFFFFFFF);
  static const Color textSecondaryColor = Color(0xFFB0B0B0);
  static const Color textTertiaryColor = Color(0xFF808080);
  
  // Gradient Colors
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: primaryColor,
      
      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: accentColor,
        secondary: accentColorLight,
        tertiary: infoColor,
        surface: secondaryColor,
        error: errorColor,
        brightness: Brightness.dark,
      ),
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: secondaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.kalpurush(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimaryColor,
        ),
        iconTheme: const IconThemeData(color: accentColor),
      ),
      
      // Text Themes
      textTheme: TextTheme(
        displayLarge: GoogleFonts.kalpurush(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: textPrimaryColor,
        ),
        displayMedium: GoogleFonts.kalpurush(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: textPrimaryColor,
        ),
        displaySmall: GoogleFonts.kalpurush(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: textPrimaryColor,
        ),
        headlineMedium: GoogleFonts.kalpurush(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimaryColor,
        ),
        headlineSmall: GoogleFonts.kalpurush(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimaryColor,
        ),
        titleLarge: GoogleFonts.kalpurush(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimaryColor,
        ),
        titleMedium: GoogleFonts.kalpurush(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textSecondaryColor,
        ),
        titleSmall: GoogleFonts.kalpurush(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textTertiaryColor,
        ),
        bodyLarge: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textPrimaryColor,
        ),
        bodyMedium: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondaryColor,
        ),
        bodySmall: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textTertiaryColor,
        ),
      ),
      
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.kalpurush(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accentColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          side: const BorderSide(color: accentColor, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.kalpurush(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: secondaryColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: secondaryColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: accentColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorColor, width: 1),
        ),
        hintStyle: GoogleFonts.roboto(
          color: textTertiaryColor,
          fontSize: 14,
        ),
        labelStyle: GoogleFonts.kalpurush(
          color: textSecondaryColor,
          fontSize: 14,
        ),
      ),
      
      // Card Theme
      cardTheme: CardTheme(
        color: secondaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(8),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: accentColor,
        size: 24,
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: Color(0xFF3A3A3A),
        thickness: 1,
        space: 16,
      ),
      
      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: accentColor,
        linearMinHeight: 4,
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: secondaryColor,
        selectedColor: accentColor,
        labelStyle: GoogleFonts.roboto(color: textPrimaryColor),
        secondaryLabelStyle: GoogleFonts.roboto(color: accentColor),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: const BorderSide(color: Color(0xFF3A3A3A)),
      ),
    );
  }
}