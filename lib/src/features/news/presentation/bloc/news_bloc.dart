import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/features/news/domain/news_repository.dart';
import 'package:gold_silver/src/features/news/presentation/bloc/news_event.dart';
import 'package:gold_silver/src/features/news/presentation/bloc/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  NewsBloc({required this.repository}) : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      emit(NewsLoading());
      try {
        final currentLocale = Localizations.localeOf(event.context);
        final res = await repository.fetchNews(currentLocale);
        emit(NewsLoaded(res.articles));
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });
  }
}
