import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFFFF5FB); // rosa bem claro
  static const card = Colors.white;
  static const primary = Color(0xFFFF2F92);
  static const primary2 = Color(0xFF9B5CFF);
  static const textDark = Color(0xFF333333);
  static const textLight = Color(0xFF888888);
  static const border = Color(0xFFE5E5E5);
  static const success = Color(0xFF00C853);
  static const canceled = Color(0xFF9E9E9E);
}

class AppTheme {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    useMaterial3: true,
    fontFamily: 'Roboto',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
  );
}

Gradient appGradient() =>
    const LinearGradient(colors: [AppColors.primary, AppColors.primary2]);
