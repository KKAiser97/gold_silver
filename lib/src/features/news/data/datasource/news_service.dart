import 'package:flutter/material.dart';
import 'package:gold_silver/src/core/client/dio_client.dart';
import 'package:gold_silver/src/features/news/domain/models/news_model.dart';
import 'package:gold_silver/src/utils/constants.dart';
import 'package:intl/intl.dart';

abstract class NewsService {
  Future<NewsModel> fetchNews(Locale locale);
}

class NewsServiceImpl implements NewsService {
  final NewsDioClient newsClient;

  NewsServiceImpl(this.newsClient);

  @override
  Future<NewsModel> fetchNews(Locale locale) async {
    try {
      bool isVN = locale.languageCode == 'vi';
      String sampleSource = 'cbs-news';
      String sampleDomain = 'wsj.com';
      var fromDate = DateTime.now().subtract(const Duration(days: 14));
      var fromDateString = DateFormat('yyyy-MM-dd').format(fromDate);
      final path = isVN
          ? 'everything?q="giá vàng" OR "giá bạc" OR "tỷ giá" OR "thị trường vàng" OR "kim loại quý"&language=vi&from=$fromDateString&sortBy=publishedAt&apiKey=${AppConstant.apiKeyNews}'
          : 'everything?q="gold price" OR "silver price" OR "precious metal"&language=en&from=$fromDateString&sortBy=publishedAt&sources=$sampleSource&domains=$sampleDomain&apiKey=${AppConstant.apiKeyNews}';
      final news = await newsClient.dio.get(path);
      return NewsModel.fromJson(news.data);
    } catch (e) {
      rethrow;
    }
  }
}
