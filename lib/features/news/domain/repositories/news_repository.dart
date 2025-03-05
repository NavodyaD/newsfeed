
import '../entities/news_article.dart';

abstract class NewsRepository {
  Future<List<NewsArticle>> getTopNewsHeadlines();
  Future<List<NewsArticle>> searchNews(List<String> keywords);
}
