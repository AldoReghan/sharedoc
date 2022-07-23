import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sharedoc/core/entity/News.dart';
import 'package:http/http.dart' as http;

class NewsServices with ChangeNotifier {
  List<News> news = [];
  List<News> get listnews => news;

  set listnews(List<News> data) {
    news = data;
    notifyListeners();
  }

  Future<List<News>> getnews(context) async {
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=id&category=health&apiKey=3a5e72b0328b465282f93863afc8d036");
    final response = await http.get(url);
    final res = jsonDecode(response.body)['articles'];

    List<News> data = [];

    for (var item in res) {
      var newsdata = News.fromJson(item);
      data.add(newsdata);
    }

    listnews = data;
    return listnews;
  }
}
