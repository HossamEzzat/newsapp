import 'package:flutter/material.dart';

import '../../core/data_source/remote_data/api_config.dart';
import '../../core/data_source/remote_data/api_service.dart';
import 'models/news_article_model.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    getTopHeadline();
    getEverything();
  }

  bool topHeadlineLoading = true;
  bool everythingLoading = true;
  String? errorMessage;
  List<NewsArticleModel> newsTopHeadlineList = [];
  List<NewsArticleModel> newsEverythingList = [];
  ApiService apiservice = ApiService();

  getTopHeadline() async {
    try {
      var result = await apiservice.get(ApiConfig.topHeadlineEndpoint);
      newsTopHeadlineList = ((result["articles"])
          .map((e) => NewsArticleModel.fromJson(e))
          .toList());
      topHeadlineLoading = false;
      errorMessage = null;
    } catch (e) {
      everythingLoading = true;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  getEverything() async {
    try {
      ApiService apiservice = ApiService();
      var result = await apiservice.get(ApiConfig.everythingEndpoint);
      newsEverythingList =
          ((result["articles"] as List)
                  .map((e) => NewsArticleModel.fromJson(e))
                  .toList())
              .cast<NewsArticleModel>();
      everythingLoading = false;
      errorMessage = null;
    } catch (e) {
      everythingLoading = true;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
