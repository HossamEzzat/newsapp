import 'package:flutter/material.dart';
import 'package:newsapp/feature/home/home_controller.dart';
import 'package:provider/provider.dart';

import 'controller/onboarding_controller.dart';
import 'core/theme/app_theme.dart';
import 'feature/auth/login_screen/login_screen.dart';
import 'feature/home/homescreen.dart';
import 'feature/main_screen/MainScreen.dart';
import 'feature/onboarding/onboarding_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) {
        return HomeController();
      },
      child: const MyApp(),
    ),
  );
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
        home: Mainscreen(),
      ),
    );
  }
}
