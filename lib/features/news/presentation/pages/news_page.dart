import 'package:flutter/material.dart';

import '../../data/datasource/news_api_service.dart';
import '../../domain/entities/news_article.dart';
import '../widgets/news_article_card.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<NewsFeedPage> {
  late Future<List<NewsArticle>> _newsFuture;
  final NewsApiService _newsApiService = NewsApiService();

  @override
  void initState() {
    super.initState();
    _newsFuture = _newsApiService.getTopNewsHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewsFeed'),
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: _newsFuture, // listen to _newsFuture
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news available'));
          } else {
            // refresh-indicator | pull-to-refresh
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _newsFuture = _newsApiService.getTopNewsHeadlines();
                });
              },
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return NewsArticleCard(article: snapshot.data![index]);
                },
              ),
            );
          }
        },
      ),
    );
  }
}