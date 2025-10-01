import 'package:flutter/material.dart';

import 'core/app_theme.dart';
import 'feature/onboarding/onboarding_screen.dart';
import 'feature/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: OnboardingScreen(),
    );
  }
}

