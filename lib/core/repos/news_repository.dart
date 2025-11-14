import '../../../core/data_source/remote_data/api_config.dart';
import '../../../core/data_source/remote_data/api_service.dart';
import '../../feature/home/models/news_article_model.dart';

class NewsRepository {
  NewsRepository(this.apiService);

  final BaseApiService apiService;

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

  Future<List<NewsArticleModel>> getEverything({String? q = "news"}) async {
    final result = await apiService.get(
      ApiConfig.everythingEndpoint,
      parameters: {"q": q},
    );
    final articles = (result["articles"] as List?) ?? [];

    return articles
        .map((e) => NewsArticleModel.fromJson(e))
        .toList()
        .cast<NewsArticleModel>();
  }
}
