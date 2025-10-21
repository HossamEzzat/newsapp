import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/feature/home/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_cached_network_image.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  // Define a placeholder URL for the avatar in case the article image URL is used for it
  static const String _defaultAvatarUrl =
      "https://via.placeholder.com/100/CCCCCC/808080?text=A";

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, provider, child) {
        return SliverList.builder(
          itemCount: provider.newsTopHeadlineList.length,
          itemBuilder: (context, index) {
            final article = provider.newsTopHeadlineList[index];

            // Define the image URL for the avatar, ensuring it's a valid string
            final String avatarImageUrl =
                (article.urlToImage != null && article.urlToImage!.isNotEmpty)
                ? article.urlToImage!
                : _defaultAvatarUrl;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                      color: AppColors.textSecondColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    DateFormat('MMM dd').format(
                                      DateTime.parse(article.publishedAt),
                                    ),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.textSecondColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.bookmark_border_outlined),
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
        );
      },
    );
  }
}
