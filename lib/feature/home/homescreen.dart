import 'dart:math';
import 'package:intl/intl.dart';
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  article.urlToImage ??
                                      "https://via.placeholder.com/140x70",
                                  width: 140,
                                  height: 70,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 140,
                                      height: 70,
                                      color: Colors.grey,
                                      child: const Icon(
                                        Icons.broken_image,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article.title,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundImage: NetworkImage(
                                            article.urlToImage ?? '',
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text(
                                                (' ${article.author ?? 'Hossam'}.')
                                                    .substring(
                                                      0,
                                                      min(
                                                        10,
                                                        (' ${article.author ?? 'Hossam'}.')
                                                            .length,
                                                      ),
                                                    ),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color:
                                                      AppColors.textSecondColor,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                DateFormat(
                                                  'MMM dd, yyyy',
                                                ).format(
                                                  DateTime.parse(
                                                    article.publishedAt,
                                                  ),
                                                ),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color:
                                                      AppColors.textSecondColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
