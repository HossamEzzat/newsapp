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
  bool topHeadlineLoading = true;

  //bool everythingLoading = true;
  String? errorMessage;

  List<NewsArticleModel> newsTopHeadlineList = [];
  List<NewsArticleModel> newsEverythingList = [];

  final ApiService apiService = ApiService();

  /// Fetch top headlines
  Future<void> getTopHeadline() async {
    try {
      topHeadlineLoading = true;
      notifyListeners();

      final result = await apiService.get(ApiConfig.topHeadlineEndpoint);
      final articles = (result["articles"] as List?) ?? [];

      newsTopHeadlineList = articles
          .map((e) => NewsArticleModel.fromJson(e))
          .toList()
          .cast<NewsArticleModel>();

      errorMessage = null;
    } catch (e) {
      errorMessage = "Failed to load top headlines: $e";
    } finally {
      topHeadlineLoading = false;
      notifyListeners();
    }
  }

  /// Fetch everything news
  Future<void> getEverything() async {
    try {
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
}
