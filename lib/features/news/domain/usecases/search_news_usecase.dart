import '../entities/news_article.dart';
import '../repositories/news_repository.dart';

class SearchNewsUseCase {
  final NewsRepository repository;

  SearchNewsUseCase(this.repository);

  Future<List<NewsArticle>> call(List<String> keywords) async {
    if (keywords.isEmpty || keywords.every((k) => k.trim().isEmpty)) {
      return [];
    }

    return await repository.searchNews(keywords);
  }
}
