import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel {
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "totalResults")
  num totalResults;
  @JsonKey(name: "articles")
  List<Article> articles;

  NewsModel({
    this.status = '',
    this.totalResults = 0,
    this.articles = const [],
  });

  NewsModel copyWith({
    String? status,
    num? totalResults,
    List<Article>? articles,
  }) =>
      NewsModel(
        status: status ?? this.status,
        totalResults: totalResults ?? this.totalResults,
        articles: articles ?? this.articles,
      );

  factory NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}

@JsonSerializable()
class Article {
  @JsonKey(name: "source")
  Source source;
  @JsonKey(name: "author")
  String author;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "url")
  String url;
  @JsonKey(name: "urlToImage")
  String urlToImage;
  @JsonKey(name: "publishedAt")
  String publishedAt;
  @JsonKey(name: "content")
  String content;

  Article({
    Source? source,
    this.author = '',
    this.title = '',
    this.description = '',
    this.url = '',
    this.urlToImage = '',
    this.publishedAt = '',
    this.content = '',
  }) : source = source ?? Source();

  Article copyWith({
    Source? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) =>
      Article(
        source: source ?? this.source,
        author: author ?? this.author,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        urlToImage: urlToImage ?? this.urlToImage,
        publishedAt: publishedAt ?? this.publishedAt,
        content: content ?? this.content,
      );

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

@JsonSerializable()
class Source {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "name")
  String name;

  Source({
    this.id = '',
    this.name = '',
  });

  Source copyWith({
    dynamic id,
    String? name,
  }) =>
      Source(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
