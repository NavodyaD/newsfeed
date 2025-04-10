class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String source;
  final String publishedAt;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.source,
    required this.publishedAt,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      // handled null values
      title: json['title'] as String? ?? 'No title',
      description: json['description'] as String? ?? 'No description available',
      url: json['url'] as String? ?? '',
      imageUrl: json['urlToImage'] as String? ?? '',
      source: json['source']?['name'] as String? ?? 'Unknown source',
      publishedAt: json['publishedAt'] as String? ?? 'Unknown date',
    );
  }
}