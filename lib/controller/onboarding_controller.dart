import 'package:flutter/material.dart';

class OnboardingController with ChangeNotifier {
  late PageController pageController;
  int _currentPage = 0;

  int get currentPage => _currentPage;

  OnboardingController() {
    pageController = PageController();
  }

  void nextPage() {
    if (_currentPage < 2) { // Assuming 3 pages (0,1,2)
      pageController.nextPage(
        duration: Duration(milliseconds: 1200),
        curve: Curves.ease,
      );
    }
  }

  void updateCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  bool get isLastPage => _currentPage == 2;

  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}