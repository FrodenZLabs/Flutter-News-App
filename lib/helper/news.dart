import 'dart:convert';

import 'package:flutter_news_app/models/article.dart';
import 'package:flutter_news_app/secret.dart';
import 'package:http/http.dart' as http;

class News {
  List<Article> news = [];

  Future<void> getNews() async {
    String url = "https://newsapi.org/v2/top-headlines?language=en&apiKey=$apiKey";

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'ok') {
          jsonData['articles'].forEach((element) {
            if (element['urlToImage'] != null && element['description'] != null) {
              Article article = Article(
                title: element['title'] ?? 'No Title',
                author: element['author'] ?? 'Unknown Author',
                description: element['description'] ?? 'No Description',
                urlToImage: element['urlToImage'] ?? '',
                publishedAt: DateTime.tryParse(element['publishedAt'] ?? '') ?? DateTime.now(),
                content: element['content'] ?? '',
                articleUrl: element['url'] ?? '',
              );
              news.add(article);
            }
          });
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Failed to load news: $e");
    }
  }
}

class NewsForCategory {
  List<Article> news = [];

  Future<void> getNewsForCategory(String category) async {
    String url = "http://newsapi.org/v2/top-headlines?language=en&category=$category&apiKey=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body);

      if (jsonData['status'] == 'ok') {
        jsonData['articles'].forEach((element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            Article article = Article(
              title: element['title'] ?? 'No Title',
              author: element['author'] ?? 'Unknown Author',
              description: element['description'] ?? 'No Description',
              urlToImage: element['urlToImage'] ?? '',
              publishedAt: DateTime.tryParse(element['publishedAt'] ?? '') ?? DateTime.now(),
              content: element['content'] ?? '',
              articleUrl: element['url'] ?? '',
            );
            news.add(article);
          }
        });
      } else {
        throw Exception("Failed to load news: ${jsonData['message']}");
      }
    } catch (e) {
      print("Error fetching news: $e");
      throw e;
    }
  }
}