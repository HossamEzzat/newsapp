import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ViewAllComponents extends StatelessWidget {
  const ViewAllComponents({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
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
    );
  }
}
