import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/core/enums/requset_status_enums.dart';
import 'package:newsapp/feature/home/components/view_all_components.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_cached_network_image.dart';
import '../home_controller.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
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
                  ViewAllComponents(
                    title: "Trending News",
                    titleColor: AppColors.backgroundColor,
                    onTap: () {},
                  ),
                  SizedBox(height: 16.0.h),

                  SizedBox(
                    height: 90,
                    child: Consumer<HomeController>(
                      builder: (context, provider, child) {
                        switch (provider.everythingStatus) {
                          case RequsetStatusEnums.loading:
                            return Center(
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white,
                                child: Container(
                                  width: 230,
                                  height: 200,
                                  color: Colors.grey,
                                ),
                              ),
                            );
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

                                // CORRECTED: Use .isEmpty to check for "" as well as null/default
                                final String imageUrl =
                                    newsItem.urlToImage != null &&
                                        newsItem.urlToImage!.isNotEmpty
                                    ? newsItem.urlToImage!
                                    : "https://via.placeholder.com/230x200";

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CustomCachedNetworkImage(
                                        imageUrl: imageUrl,
                                        width: 230,
                                        height: 200,
                                        fit: BoxFit.fill,
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
      ),
    );
  }
}
