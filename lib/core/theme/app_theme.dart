import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.backgroundColor,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: AppColors.primaryColor),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.backgroundColor,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.textSecondColor,
    type: BottomNavigationBarType.fixed,
  ),
);
