import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ViewAllComponents extends StatelessWidget {
  ViewAllComponents({
    super.key,
    required this.title,
    required this.titleColor,
    required this.onTap,
  });

  String title;
  Color titleColor;
  Function onTap = () {};

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
              color: titleColor,
              fontSize: 16,
            ),
          ),
          TextButton(
            onPressed: () => onTap(),
            child: Text(
              "View all",
              style: TextStyle(
                color: titleColor,
                decoration: TextDecoration.underline,
                decorationColor: titleColor,
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
