import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../home_controller.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.asset(
              "assets/images/home_back.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset("assets/images/vec.png"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trending News",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.backgroundColor,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "View all",
                          style: TextStyle(
                            color: AppColors.backgroundColor,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.backgroundColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                SizedBox(
                  height: 90,
                  child: Consumer<HomeController>(
                    builder: (context, provider, child) {
                      return (provider.errorMessage?.isNotEmpty ?? false)
                          ? Center(
                              child: Text(
                                provider.errorMessage.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            )
                          : provider.everythingLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: provider.newsEverythingList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                final newsItem =
                                    provider.newsEverythingList[index];
                                final imageUrl =
                                    newsItem.urlToImage ??
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTO6OyfeCvk89wc0YZsJUBxpksq4iEqaxWiA&s";
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      imageUrl,
                                      width: 130,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              width: 120,
                                              height: 90,
                                              color: Colors.grey[300],
                                              child: const Icon(
                                                Icons.broken_image,
                                                color: Colors.grey,
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                );
                              },
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
