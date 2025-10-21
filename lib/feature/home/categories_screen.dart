import 'dart:math'; // This import is fine, it's used for min()

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/feature/home/home_controller.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/custom_cached_network_image.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const String _defaultAvatarUrl =
      "https://via.placeholder.com/100/CCCCCC/808080?text=A";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories"), centerTitle: true),
      body: Consumer<HomeController>(
        builder: (context, provider, child) {
          // FIX: The articles ListView.builder needs to be wrapped in Expanded
          // because it is inside a Column.
          return Column(
            children: [
              SizedBox(
                height: 30,
                child: ListView.builder(
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    bool isSelected =
                        provider.selectedCategory == categories[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: GestureDetector(
                        onTap: () {
                          provider.selectCategory(categories[index]);
                        },
                        child: IntrinsicWidth(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // Added this to space out text and line
                            children: [
                              Text(
                                categories[index][0].toUpperCase() +
                                    categories[index].substring(1),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: isSelected
                                      ? AppColors
                                            .primaryColor // Highlight selected text
                                      : AppColors.textSecondColor,
                                ),
                              ),
                              if (isSelected)
                                Container(
                                  height: 2,
                                  color: AppColors.primaryColor,
                                  // The width will be managed by IntrinsicWidth
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10), // Add a small space below categories
              // FIX: Wrap the article list in Expanded
              Expanded(
                child: ListView.builder(
                  itemCount: provider.newsTopHeadlineList.length,
                  itemBuilder: (context, index) {
                    final article = provider.newsTopHeadlineList[index];

                    // Define the image URL for the avatar, ensuring it's a valid string
                    final String avatarImageUrl =
                        (article.urlToImage != null &&
                            article.urlToImage!.isNotEmpty)
                        ? article.urlToImage!
                        : _defaultAvatarUrl;

                    // Determine the author string and handle null/empty case
                    final String authorName =
                        article.author ?? 'Unknown Source';

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          // 1. Main Article Image
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title ?? 'No Title Available',
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
                                    // 2. Avatar Image
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
                                            // Kept the author length logic, but simplified the string creation
                                            authorName.substring(
                                              0,
                                              min(10, authorName.length),
                                            ),
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.textSecondColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(width: 5),
                                          // Note: You should handle a potential null/invalid `publishedAt`
                                          Text(
                                            DateFormat('MMM dd').format(
                                              DateTime.tryParse(
                                                    article.publishedAt ?? '',
                                                  ) ??
                                                  DateTime.now(),
                                            ),
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.textSecondColor,
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
          );
        },
      ),
    );
  }
}

List<String> categories = [
  "business",
  "entertainment",
  "general",
  "health",
  "science",
  "sports",
  "technology",
];
