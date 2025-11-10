import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppThemes {
  // Світла тема
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.transparent, // Прозорий для градієнтів
    colorScheme: const ColorScheme.light(
      primary: AppColors.goldenAccent,
      secondary: AppColors.lightGold,
      surface: AppColors.white,
      error: AppColors.error,
      onPrimary: AppColors.darkBrownText,
      onSecondary: AppColors.darkBrownText,
      onSurface: AppColors.darkBrownText,
      onError: AppColors.white,
    ),
    
    // Текстові стилі
    textTheme: TextTheme(
      displayLarge: GoogleFonts.merriweather(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBrownText,
      ),
      displayMedium: GoogleFonts.merriweather(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBrownText,
      ),
      displaySmall: GoogleFonts.merriweather(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.darkBrownText,
      ),
      headlineMedium: GoogleFonts.merriweather(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.darkBrownText,
      ),
      headlineSmall: GoogleFonts.merriweather(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.darkBrownText,
      ),
      titleLarge: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBrownText,
      ),
      titleMedium: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.darkBrownText,
      ),
      titleSmall: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.darkBrownText,
      ),
      bodyLarge: GoogleFonts.merriweather(
        fontSize: 16,
        color: AppColors.darkBrownText,
      ),
      bodyMedium: GoogleFonts.merriweather(
        fontSize: 14,
        color: AppColors.darkBrownText,
      ),
      bodySmall: GoogleFonts.nunito(
        fontSize: 12,
        color: AppColors.softBrown,
      ),
      labelLarge: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.darkBrownText,
      ),
    ),
    
    // Кнопки
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.goldenAccent,
        foregroundColor: AppColors.darkBrownText,
        textStyle: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    
    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.darkBrownText,
      elevation: 0,
      titleTextStyle: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBrownText,
      ),
    ),
    
    // Карточки
    cardTheme: CardThemeData(
      color: AppColors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    
    // Поля введення
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.lightGold),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.lightGold),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.goldenAccent, width: 2),
      ),
      labelStyle: GoogleFonts.nunito(color: AppColors.softBrown),
      hintStyle: GoogleFonts.nunito(color: AppColors.softBrown),
    ),
  );

  // Темна тема з правильними кольорами
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent, // Прозорий для градієнтів
    colorScheme: const ColorScheme.dark(
      primary: AppColors.goldenAccent,
      secondary: AppColors.lightGold,
      surface: Color(0xFF1E293B), // Темна поверхня
      error: AppColors.error,
      onPrimary: AppColors.darkBrownText,
      onSecondary: AppColors.darkBrownText,
      onSurface: Color(0xFFF8FAFC), // Світлий текст
      onError: AppColors.white,
    ),
    
    textTheme: TextTheme(
      displayLarge: GoogleFonts.merriweather(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: const Color(0xFFF8FAFC), // Світлий текст
      ),
      displayMedium: GoogleFonts.merriweather(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: const Color(0xFFF8FAFC),
      ),
      displaySmall: GoogleFonts.merriweather(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: const Color(0xFFF8FAFC),
      ),
      headlineMedium: GoogleFonts.merriweather(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: const Color(0xFFF8FAFC),
      ),
      headlineSmall: GoogleFonts.merriweather(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: const Color(0xFFF8FAFC),
      ),
      titleLarge: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: const Color(0xFFF8FAFC),
      ),
      titleMedium: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: const Color(0xFFF8FAFC),
      ),
      titleSmall: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: const Color(0xFFF8FAFC),
      ),
      bodyLarge: GoogleFonts.merriweather(
        fontSize: 16,
        color: const Color(0xFFF8FAFC),
      ),
      bodyMedium: GoogleFonts.merriweather(
        fontSize: 14,
        color: const Color(0xFFF8FAFC),
      ),
      bodySmall: GoogleFonts.nunito(
        fontSize: 12,
        color: const Color(0xFFCBD5E1),
      ),
    ),
    
    // Кнопки залишаються помітними
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.goldenAccent,
        foregroundColor: AppColors.darkBrownText,
        textStyle: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: const Color(0xFFF8FAFC),
      elevation: 0,
      titleTextStyle: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: const Color(0xFFF8FAFC),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFFF8FAFC),
      ),
    ),
    
    cardTheme: CardThemeData(
      color: const Color(0xFF1E293B),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E293B),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF334155)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF334155)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.goldenAccent, width: 2),
      ),
      labelStyle: GoogleFonts.nunito(color: const Color(0xFFCBD5E1)),
      hintStyle: GoogleFonts.nunito(color: const Color(0xFF94A3B8)),
    ),
  );
}
