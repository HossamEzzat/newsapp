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
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.backgroundColor,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: AppColors.textSecondColor,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(color: AppColors.textSecondColor),
  ),
);
