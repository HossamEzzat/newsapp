import 'package:flutter/material.dart';

import '../../core/enums/requset_status_enums.dart';
import '../../core/repos/news_repository.dart';
import 'models/news_article_model.dart';

class HomeController extends ChangeNotifier {
  HomeController(this.newsRepository) {
    getTopHeadline();
    getEverything();
  }

  RequsetStatusEnums everythingStatus = RequsetStatusEnums.loading;
  RequsetStatusEnums topHeadLineStatus = RequsetStatusEnums.loading;
  bool topHeadlineLoading = true;
  bool everythingLoading = true;
  String? errorMessage;
  String? selectedCategory;

  List<NewsArticleModel> newsEverythingList = [];
  List<NewsArticleModel> newsTopHeadLineList = [];
  final NewsRepository newsRepository;

  /// Fetch top headlines
  Future<void> getTopHeadline() async {
    try {
      Future.delayed(const Duration(milliseconds: 500));
      topHeadlineLoading = true;
      notifyListeners();
      newsTopHeadLineList = await newsRepository.getTopHeadLine(
        category: selectedCategory,
      );
      topHeadLineStatus = RequsetStatusEnums.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = "Failed to load top headlines: $e";
      topHeadLineStatus = RequsetStatusEnums.error;
    } finally {
      topHeadlineLoading = false;
      notifyListeners();
    }
  }

  /// Fetch everything news
  Future<void> getEverything() async {
    try {
      Future.delayed(const Duration(milliseconds: 500));
      everythingLoading = true;
      notifyListeners();
      newsEverythingList = await newsRepository.getEverything();
      everythingLoading = false;
      everythingStatus = RequsetStatusEnums.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = "Failed to load news: $e";
      everythingStatus = RequsetStatusEnums.error;
    } finally {
      notifyListeners();
    }
    notifyListeners();
  }

  void selectCategory(String category) {
    selectedCategory = category;
    getTopHeadline();
    notifyListeners();
  }
}
