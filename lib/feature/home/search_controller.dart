import 'package:flutter/material.dart';
import 'package:newsapp/core/repos/news_repository.dart';

import '../../core/enums/requset_status_enums.dart';
import 'models/news_article_model.dart';

class SearchScreenController extends ChangeNotifier {
  SearchScreenController(this.newsRepository);

  final NewsRepository newsRepository;
  TextEditingController searchController = TextEditingController();
  bool everythingLoading = true;
  String? errorMessage;
  RequsetStatusEnums everythingStatus = RequsetStatusEnums.loading;
  List<NewsArticleModel> newsEverythingList = [];

  Future<void> getEverything() async {
    try {
      Future.delayed(const Duration(milliseconds: 500));
      everythingLoading = true;
      notifyListeners();
      newsEverythingList = await newsRepository.getEverything(
        q: searchController.text,
      );
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
}
