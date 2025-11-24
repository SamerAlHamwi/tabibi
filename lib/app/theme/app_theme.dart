import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    primaryColor: AppColors.primary, // AppColors.primary
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    fontFamily: 'Roboto',

    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.scaffoldBackground,
        statusBarIconBrightness: Brightness.dark,  // أيقونات داكنة (على خلفية فاتحة)
        statusBarBrightness: Brightness.light,     // لأجهزة iOS
      ),
      backgroundColor: AppColors.scaffoldBackground,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      elevation: 0,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.lightGray,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
      ),
    ),
    iconTheme: IconThemeData(
      color: AppColors.primary,
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.black,
      indicatorColor: AppColors.primary,
    ),

  );

  static ThemeData get dark => ThemeData.dark().copyWith(
    useMaterial3: false,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: const Color(0xFF008080),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF008080),
      secondary: Colors.tealAccent,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.tealAccent,
      unselectedItemColor: Colors.grey,
    ),
  );

}
