import 'package:flutter/material.dart';
import 'package:newsapp/core/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'components/categories_component.dart';
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
              body: CustomScrollView(
                slivers: [
                  TrendingNews(),
                  SliverToBoxAdapter(
                    child: ViewAllComponents(
                      onTap: () {},
                      title: "categories",
                      titleColor: AppColors.textSecondColor,
                    ),
                  ),
                  CategoriesComponent(),
                  Expanded(
                    child: SliverList.builder(
                      itemCount: provider.newsTopHeadlineList.length,
                      itemBuilder: (context, index) {
                        final article = provider.newsTopHeadlineList[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Card(
                            child: ListTile(
                              title: Text(article.title ?? 'No Title'),
                              subtitle: Text(
                                article.description ?? 'No Description',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
