import '../../../core/data_source/remote_data/api_config.dart';
import '../../../core/data_source/remote_data/api_service.dart';
import '../models/news_article_model.dart';

class NewsRepository {
  final ApiService apiService = ApiService();

  Future<List<NewsArticleModel>> getTopHeadLine({String? category}) async {
    final result = await apiService.get(
      "${ApiConfig.topHeadlineEndpoint}${category != null ? '&category=$category' : ''}",
    );

    final articles = (result["articles"] as List?) ?? [];

    return articles
        .map((e) => NewsArticleModel.fromJson(e))
        .toList()
        .cast<NewsArticleModel>();
  }

  Future<List<NewsArticleModel>> getEverything() async {
    final result = await apiService.get(ApiConfig.everythingEndpoint);
    final articles = (result["articles"] as List?) ?? [];

    return articles
        .map((e) => NewsArticleModel.fromJson(e))
        .toList()
        .cast<NewsArticleModel>();
  }
}
