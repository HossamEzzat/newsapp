import 'package:flutter/material.dart';
import 'package:newsapp/feature/home/components/view_all_components.dart';
import 'package:newsapp/feature/home/home_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../categories_screen.dart';

class CategoriesComponent extends StatelessWidget {
  const CategoriesComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, provider, child) {
        return SliverToBoxAdapter(
          child: Column(
            children: [
              ViewAllComponents(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoriesScreen(),
                    ),
                  );
                },
                title: "categories",
                titleColor: AppColors.textSecondColor,
              ),
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
                            children: [
                              Text(
                                categories[index][0].toUpperCase() +
                                    categories[index].substring(1),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: AppColors.textSecondColor,
                                ),
                              ),
                              if (isSelected)
                                Container(
                                  height: 2,
                                  color: AppColors.primaryColor,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
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
