import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/core/constants/app_size.dart';
import 'package:newsapp/core/data_source/remote_data/api_service.dart';
import 'package:newsapp/core/repos/news_repository.dart';
import 'package:newsapp/feature/home/search_controller.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/custom_cached_network_image.dart';
import '../detail/news_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const String _defaultAvatarUrl =
      "https://via.placeholder.com/100/CCCCCC/808080?text=A";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchScreenController(NewsRepository(ApiService())),
      child: Scaffold(
        appBar: AppBar(title: const Text("Search"), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<SearchScreenController>(
            builder: (context, controller, child) {
              return Column(
                children: [
                  TextField(
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.getEverything();
                    },
                    decoration: InputDecoration(
                      hint: Text("Search"),
                      suffixIcon: Icon(
                        Icons.search,
                        size: AppSize.r30,
                        color: Color(0xffA0A0A0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.newsEverythingList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final article = controller.newsEverythingList[index];

                        final String avatarImageUrl =
                            (article.urlToImage != null &&
                                article.urlToImage!.isNotEmpty)
                            ? article.urlToImage!
                            : _defaultAvatarUrl;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NewsDetailScreen(newsArticle: article),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                // 1. Main Article Image (Already using CachedNetworkImage)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CustomCachedNetworkImage(
                                    imageUrl:
                                        (article.urlToImage != null &&
                                            article.urlToImage!.isNotEmpty)
                                        ? article.urlToImage!
                                        : "https://via.placeholder.com/140x70",
                                    width: 140,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          // 2. Avatar Image (Replaced NetworkImage with CachedNetworkImage)
                                          ClipOval(
                                            child: CustomCachedNetworkImage(
                                              imageUrl: avatarImageUrl,
                                              width: 20,
                                              height: 20,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
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
                                                    color: AppColors
                                                        .textSecondColor,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  DateFormat('MMM dd').format(
                                                    DateTime.parse(
                                                      article.publishedAt,
                                                    ),
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: AppColors
                                                        .textSecondColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.bookmark_border_outlined,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
