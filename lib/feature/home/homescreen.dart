import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/data_source/remote_data/api_service.dart';
import '../../core/repos/news_repository.dart';
import 'components/categories_component.dart';
import 'components/top_headline.dart';
import 'components/trending_news.dart';
import 'home_controller.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          HomeController(NewsRepository(ApiService())),
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
