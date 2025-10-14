import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xfff5f5f5),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Color(0xffC53030)),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xffF6F7F9),
    selectedItemColor: Color(0xffC53030),
    unselectedItemColor: Color(0xff363636),
    type: BottomNavigationBarType.fixed,
  ),
);
