import 'package:flutter/material.dart';
import 'package:newsapp/feature/home/repos/news_repository.dart';
import 'package:provider/provider.dart';

import 'components/categories_component.dart';
import 'components/top_headline.dart';
import 'components/trending_news.dart';
import 'home_controller.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeController(NewsRepository()),
      child: Consumer<HomeController>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Scaffold(
              body: CustomScrollView(
                slivers: [TrendingNews(), CategoriesComponent(), TopHeadline()],
              ),
            ),
          );
        },
      ),
    );
  }
}
