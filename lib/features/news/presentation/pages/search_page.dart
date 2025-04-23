import 'package:flutter/material.dart';

import '../../domain/entities/news_article.dart';
import '../../domain/usecases/search_news_usecase.dart';
import '../widgets/news_article_card.dart';

class NewsSearchPage extends StatefulWidget {
  final SearchNewsUseCase searchNewsUseCase;

  NewsSearchPage({required this.searchNewsUseCase});

  @override
  _NewsSearchPageState createState() => _NewsSearchPageState();
}

class _NewsSearchPageState extends State<NewsSearchPage> {
  late Future<List<NewsArticle>> _newsFuture;
  final TextEditingController _keyword1Controller = TextEditingController();
  final TextEditingController _keyword2Controller = TextEditingController();
  final TextEditingController _keyword3Controller = TextEditingController();
  final TextEditingController _keyword4Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _newsFuture = Future.value([]);  // Initialize with empty list
  }

  void _searchNews() {
    final keywords = [
      _keyword1Controller.text,
      _keyword2Controller.text,
      _keyword3Controller.text,
      _keyword4Controller.text,
    ];

    setState(() {
      _newsFuture = widget.searchNewsUseCase.call(keywords); // do search
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Search News', style: TextStyle(fontWeight: FontWeight.bold),)),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter keywords for search", style: TextStyle(fontSize: 16),),
            SizedBox(height: 10,),
            TextField(
              controller: _keyword1Controller,
              decoration: InputDecoration(labelText: 'Enter 1st Keyword'),
            ),
            TextField(
              controller: _keyword2Controller,
              decoration: InputDecoration(labelText: 'Enter 2nd Keyword'),
            ),
            TextField(
              controller: _keyword3Controller,
              decoration: InputDecoration(labelText: 'Enter 3rd Keyword'),
            ),
            TextField(
              controller: _keyword4Controller,
              decoration: InputDecoration(labelText: 'Enter 4th Keyword'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _searchNews,
              label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, color: Colors.white),
                    SizedBox(width: 6,),
                    Text(
                      'Search News',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900], // Dark blue
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.zero, // Padding handled inside label
                elevation: 4,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<NewsArticle>>(
                future: _newsFuture, // listen to _newsFuture
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No news available for your search'));
                  } else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        setState(() {
                          _newsFuture = widget.searchNewsUseCase.call([
                            _keyword1Controller.text,
                            _keyword2Controller.text,
                            _keyword3Controller.text,
                            _keyword4Controller.text
                          ]); // fetch again for re-fresh
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
            ),
          ],
        ),
      ),
    );
  }
}
