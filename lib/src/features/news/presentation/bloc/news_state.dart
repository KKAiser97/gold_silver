import 'package:equatable/equatable.dart';
import 'package:gold_silver/src/features/news/domain/models/news_model.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<Article> news;

  const NewsLoaded(this.news);

  @override
  List<Object?> get props => [news];
}

class NewsError extends NewsState {
  final String message;
  final DateTime timestamp;

  ///MARK: Added timestamp to guarantee uniqueness of error state (bloc compares old state with new state to trigger UI update)

  NewsError(this.message) : timestamp = DateTime.now();

  @override
  List<Object?> get props => [message, timestamp];
}
