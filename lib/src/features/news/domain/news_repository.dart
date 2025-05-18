import 'package:flutter/material.dart';
import 'package:gold_silver/src/features/news/domain/models/news_model.dart';

abstract class NewsRepository {
  Future<NewsModel> fetchNews(Locale locale);
}
