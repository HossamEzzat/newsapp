import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/feature/home/home_controller.dart';
import 'package:provider/provider.dart';

import 'controller/onboarding_controller.dart';
import 'core/theme/app_theme.dart';
import 'feature/home/repos/news_repository.dart';
import 'feature/main_screen/MainScreen.dart';

Future<void> main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) {
        return HomeController(NewsRepository());
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
      child: ScreenUtilInit(
        designSize: const Size(375, 832),
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          home: Mainscreen(),
        ),
      ),
    );
  }
}
