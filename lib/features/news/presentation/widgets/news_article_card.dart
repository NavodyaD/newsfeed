import 'package:flutter/material.dart';

import '../../domain/entities/news_article.dart';

class NewsArticleCard extends StatelessWidget {
  final NewsArticle article;

  const NewsArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // log the article rendering
    print('Rendering article: ${article.title}');

    return Card(  
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          article.imageUrl.isNotEmpty
              ? Image.network(
            article.imageUrl,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(child: Text('No News Image')),
              );
            },
          )
              : Container(
            height: 200,
            color: Colors.grey[300],
            child: const Center(child: Text('No News Image Loaded')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  article.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Source: ${article.source}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Text(
                      article.publishedAt.substring(0, 10),
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}