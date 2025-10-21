import 'package:flutter/material.dart';
import '../../core/data_source/remote_data/api_config.dart';
import '../../core/data_source/remote_data/api_service.dart';
import '../../core/enums/requset_status_enums.dart';
import 'models/news_article_model.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    getTopHeadline();
    getEverything();
  }

  RequsetStatusEnums everythingStatus = RequsetStatusEnums.loading;
  RequsetStatusEnums topHeadLineStatus = RequsetStatusEnums.loading;
  bool topHeadlineLoading = true;
  bool everythingLoading = true;
  String? errorMessage;
  String? selectedCategory;

  List<NewsArticleModel> newsTopHeadlineList = [];
  List<NewsArticleModel> newsEverythingList = [];

  final ApiService apiService = ApiService();

  /// Fetch top headlines
  Future<void> getTopHeadline({String? category}) async {
    try {
      Future.delayed(const Duration(milliseconds: 500));
      topHeadlineLoading = true;
      notifyListeners();

      final result = await apiService.get(
        "${ApiConfig.topHeadlineEndpoint}${category != null ? '&category=$category' : ''}",
      );

      final articles = (result["articles"] as List?) ?? [];

      newsTopHeadlineList = articles
          .map((e) => NewsArticleModel.fromJson(e))
          .toList()
          .cast<NewsArticleModel>();
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
      final result = await apiService.get(ApiConfig.everythingEndpoint);
      final articles = (result["articles"] as List?) ?? [];

      newsEverythingList = articles
          .map((e) => NewsArticleModel.fromJson(e))
          .toList()
          .cast<NewsArticleModel>();
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
    getTopHeadline(category: category);
    notifyListeners();
  }
}
