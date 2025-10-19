import 'package:flutter/material.dart';
import 'package:newsapp/core/enums/requset_status_enums.dart';
import 'package:newsapp/feature/home/components/view_all_components.dart';
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
                ViewAllComponents(title: "Trending News"),
                const SizedBox(height: 8),

                SizedBox(
                  height: 90,
                  child: Consumer<HomeController>(
                    builder: (context, provider, child) {
                      switch (provider.everythingStatus) {
                        case RequsetStatusEnums.loading:
                          return Center(child: CircularProgressIndicator());
                        case RequsetStatusEnums.error:
                          return Center(
                            child: Text(
                              provider.errorMessage.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        case RequsetStatusEnums.loaded:
                          return ListView.builder(
                            itemCount: provider.newsEverythingList
                                .take(7)
                                .length,
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
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.white,
                                      width:
                                          2.0, // Adjust border width as needed
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    // Slightly smaller than container border radius
                                    child: Image.network(
                                      imageUrl,
                                      width: 230,
                                      height: 200,
                                      fit: BoxFit.fill,
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
                                ),
                              );
                            },
                          );
                      }
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
