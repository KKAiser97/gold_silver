import 'package:json_annotation/json_annotation.dart';

part 'xchange_rate_model.g.dart';

@JsonSerializable()
class ExchangeRateModel {
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "terms")
  String terms;
  @JsonKey(name: "privacy")
  String privacy;
  @JsonKey(name: "timestamp")
  num timestamp;
  @JsonKey(name: "source")
  String source;
  @JsonKey(name: "quotes")
  Map<String, num> quotes;

  ExchangeRateModel({
    this.success = false,
    this.terms = '',
    this.privacy = '',
    this.timestamp = 0,
    this.source = '',
    this.quotes = const {},
  });

  ExchangeRateModel copyWith({
    bool? success,
    String? terms,
    String? privacy,
    num? timestamp,
    String? source,
    Map<String, num>? quotes,
  }) =>
      ExchangeRateModel(
        success: success ?? this.success,
        terms: terms ?? this.terms,
        privacy: privacy ?? this.privacy,
        timestamp: timestamp ?? this.timestamp,
        source: source ?? this.source,
        quotes: quotes ?? this.quotes,
      );

  factory ExchangeRateModel.fromJson(Map<String, dynamic> json) => _$ExchangeRateModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeRateModelToJson(this);
}
