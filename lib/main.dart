import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/onboarding_controller.dart';
import 'core/app_theme.dart';
import 'feature/onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: OnboardingScreen(),
      ),
    );
  }
}

