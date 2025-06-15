import 'package:flutter/material.dart';
import 'package:newsfeed/features/news/presentation/pages/newsdetails_page.dart';

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
        leading: IconButton(
          padding: EdgeInsets.only(left: 16),
          icon: Icon(Icons.menu, color: Colors.blue.shade900, size: 27,),
          onPressed: () {
          },
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Image.asset(
            'assets/newsfeed_logo.png',
            height: 31,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 16),
            icon: Icon(Icons.notifications_none, color: Colors.blue.shade900, size: 27,),
            onPressed: () {
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: FutureBuilder<List<NewsArticle>>(
          future: _newsFuture, // listen to _newsFuture
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No news available'));
            } else {

              print('Data Type: ${snapshot.data.runtimeType}');
              print('Data: ${snapshot.data}');

              // News data is available
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _newsFuture = _newsApiService.getTopNewsHeadlines(); // Re-fetch the news
                  });
                },
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailsPage(article: snapshot.data![index]),
                            ),
                          );
                        },
                        child: NewsArticleCard(article: snapshot.data![index])
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}