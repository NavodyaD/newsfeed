import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsfeed/variables.dart';

import '../../domain/entities/news_article.dart';

class NewsApiService {
  static String _apiKey = newsapikey;
  static const String _baseUrl = 'https://newsapi.org/v2'; // base url of News API

  // send an request to the api
  Future<List<NewsArticle>> getTopNewsHeadlines() async {
    // get top news | country = United States
    final url = '$_baseUrl/top-headlines?country=us&apiKey=$_apiKey';
    return _getNewsArticles(url);
  }

  Future<List<NewsArticle>> searchNews(List<String> keywords) async {
    final query = keywords.where((k) => k.isNotEmpty).join(' OR '); // Join keywords with 'OR'
    if (query.isEmpty) return []; // if no keywords entered

    final url = '$_baseUrl/everything?q=$query&apiKey=$_apiKey';
    return _getNewsArticles(url);
  }

  Future<List<NewsArticle>> _getNewsArticles(String url) async {
    try {
      // send a GET request to the Api with the url
      final response = await http.get(Uri.parse(url));

      // 200 OK - response is successful
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = data['articles'] as List; // extract articles of response

        // convert articles to NewsArticle objects
        return articles.map((article) => NewsArticle.fromJson(article)).toList();
      } else {
        throw Exception('Unable to load news: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting news: $e');
      return [];
    }
  }
}
