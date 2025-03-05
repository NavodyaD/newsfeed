import '../../domain/entities/news_article.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasource/news_api_service.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsApiService apiService;

  NewsRepositoryImpl(this.apiService);

  @override
  Future<List<NewsArticle>> getTopNewsHeadlines() async {
    return await apiService.getTopNewsHeadlines();
  }

  @override
  Future<List<NewsArticle>> searchNews(List<String> keywords) async {
    return await apiService.searchNews(keywords);
  }
}
