import 'package:flutter/material.dart';
import 'package:gold_silver/src/features/news/data/datasource/news_service.dart';
import 'package:gold_silver/src/features/news/domain/models/news_model.dart';
import 'package:gold_silver/src/features/news/domain/news_repository.dart';

class NewsServiceRepositoryImpl implements NewsRepository {
  final NewsService service;

  NewsServiceRepositoryImpl(this.service);

  @override
  Future<NewsModel> fetchNews(Locale locale) {
    return service.fetchNews(locale);
  }
}
