import 'package:json_annotation/json_annotation.dart';

part 'metal_model.g.dart';

@JsonSerializable()
class MetalModel {
  @JsonKey(name: "Meta Data")
  final MetaData metaData;
  @JsonKey(name: "Time Series (Daily)")
  final Map<String, TimeSeriesDaily> data;

  MetalModel({
    required this.metaData,
    required this.data,
  });

  MetalModel copyWith({
    MetaData? metaData,
    Map<String, TimeSeriesDaily>? data,
  }) =>
      MetalModel(
        metaData: metaData ?? this.metaData,
        data: data ?? this.data,
      );

  factory MetalModel.fromJson(Map<String, dynamic> json) => _$MetalModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetalModelToJson(this);
}

@JsonSerializable()
class MetaData {
  @JsonKey(name: "1. Information")
  final String information;
  @JsonKey(name: "2. Symbol")
  final String symbol;
  @JsonKey(name: "3. Last Refreshed")
  final String lastRefreshed;
  @JsonKey(name: "4. Output Size")
  final String outputSize;
  @JsonKey(name: "5. Time Zone")
  final String timeZone;

  MetaData({
    this.information = '',
    this.symbol = '',
    this.lastRefreshed = '',
    this.outputSize = '',
    this.timeZone = '',
  });

  MetaData copyWith({
    String? information,
    String? symbol,
    String? lastRefreshed,
    String? outputSize,
    String? timeZone,
  }) =>
      MetaData(
        information: information ?? this.information,
        symbol: symbol ?? this.symbol,
        lastRefreshed: lastRefreshed ?? this.lastRefreshed,
        outputSize: outputSize ?? this.outputSize,
        timeZone: timeZone ?? this.timeZone,
      );

  factory MetaData.fromJson(Map<String, dynamic> json) => _$MetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDataToJson(this);
}

@JsonSerializable()
class TimeSeriesDaily {
  @JsonKey(name: "1. open")
  final String open;
  @JsonKey(name: "2. high")
  final String high;
  @JsonKey(name: "3. low")
  final String low;
  @JsonKey(name: "4. close")
  final String close;
  @JsonKey(name: "5. volume")
  final String volume;

  TimeSeriesDaily({
    this.open = '',
    this.high = '',
    this.low = '',
    this.close = '',
    this.volume = '',
  });

  TimeSeriesDaily copyWith({
    String? open,
    String? high,
    String? low,
    String? close,
    String? volume,
  }) =>
      TimeSeriesDaily(
        open: open ?? this.open,
        high: high ?? this.high,
        low: low ?? this.low,
        close: close ?? this.close,
        volume: volume ?? this.volume,
      );

  factory TimeSeriesDaily.fromJson(Map<String, dynamic> json) => _$TimeSeriesDailyFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSeriesDailyToJson(this);
}
