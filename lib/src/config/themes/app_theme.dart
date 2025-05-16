import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.color_00A9C8,
      onPrimary: AppColors.color_FFFFFF,
      secondary: AppColors.color_006D77,
      background: AppColors.color_FFFFFF,
      onBackground: AppColors.color_CCCCCC,
      surface: AppColors.color_FFFFFF,
      onSurface: AppColors.color_CCCCCC,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.color_000000),
      bodyMedium: TextStyle(color: AppColors.color_000000),
      titleLarge: TextStyle(color: AppColors.color_000000),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.color_51AACC),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.color_51AACC,
        foregroundColor: AppColors.color_FFFFFF,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.color_51AACC,
        side: const BorderSide(color: AppColors.color_51AACC),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    ),
    scaffoldBackgroundColor: AppColors.color_FFFFFF,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.color_FFFFFF,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.color_000000),
      titleTextStyle: TextStyle(
        color: AppColors.color_000000,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.color_183D3D,
      onPrimary: AppColors.color_FFFFFF,
      secondary: AppColors.color_5C8374,
      background: AppColors.color_121212,
      onBackground: AppColors.color_FFFFFF,
      surface: AppColors.color_1E1E1E,
      onSurface: AppColors.color_FFFFFF,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    scaffoldBackgroundColor: AppColors.color_121212,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.color_121212,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.color_FFFFFF),
      titleTextStyle: TextStyle(
        color: AppColors.color_FFFFFF,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

