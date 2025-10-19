import 'package:flutter/material.dart';
import 'package:newsapp/core/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'components/trending_news.dart';
import 'components/view_all_components.dart';
import 'home_controller.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeController(),
      child: Consumer<HomeController>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  TrendingNews(),
                  ViewAllComponents(title: "categories"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
