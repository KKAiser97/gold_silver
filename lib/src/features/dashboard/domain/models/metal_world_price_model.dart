import 'package:json_annotation/json_annotation.dart';

part 'metal_world_price_model.g.dart';

@JsonSerializable()
class MetalWorldPriceModel {
  @JsonKey(name: "timestamp")
  final num timestamp;
  @JsonKey(name: "metal")
  final String metal;
  @JsonKey(name: "currency")
  final String currency;
  @JsonKey(name: "exchange")
  final String exchange;
  @JsonKey(name: "symbol")
  final String symbol;
  @JsonKey(name: "prev_close_price")
  final num prevClosePrice;
  @JsonKey(name: "open_price")
  final num openPrice;
  @JsonKey(name: "low_price")
  final num lowPrice;
  @JsonKey(name: "high_price")
  final num highPrice;
  @JsonKey(name: "open_time")
  final int openTime;
  @JsonKey(name: "price")
  final num price;
  @JsonKey(name: "ch")
  final num ch;
  @JsonKey(name: "chp")
  final num chp;
  @JsonKey(name: "ask")
  final num ask;
  @JsonKey(name: "bid")
  final num bid;
  @JsonKey(name: "price_gram_24k")
  final num priceGram24K;
  @JsonKey(name: "price_gram_22k")
  final num priceGram22K;
  @JsonKey(name: "price_gram_21k")
  final num priceGram21K;
  @JsonKey(name: "price_gram_20k")
  final num priceGram20K;
  @JsonKey(name: "price_gram_18k")
  final num priceGram18K;
  @JsonKey(name: "price_gram_16k")
  final num priceGram16K;
  @JsonKey(name: "price_gram_14k")
  final num priceGram14K;
  @JsonKey(name: "price_gram_10k")
  final num priceGram10K;

  MetalWorldPriceModel({
    this.timestamp = 0,
    this.metal = '',
    this.currency = '',
    this.exchange = '',
    this.symbol = '',
    this.prevClosePrice = 0,
    this.openPrice = 0,
    this.lowPrice = 0,
    this.highPrice = 0,
    this.openTime = 0,
    this.price = 0,
    this.ch = 0,
    this.chp = 0,
    this.ask = 0,
    this.bid = 0,
    this.priceGram24K = 0,
    this.priceGram22K = 0,
    this.priceGram21K = 0,
    this.priceGram20K = 0,
    this.priceGram18K = 0,
    this.priceGram16K = 0,
    this.priceGram14K = 0,
    this.priceGram10K = 0,
  });

  MetalWorldPriceModel copyWith({
    num? timestamp,
    String? metal,
    String? currency,
    String? exchange,
    String? symbol,
    num? prevClosePrice,
    num? openPrice,
    num? lowPrice,
    num? highPrice,
    int? openTime,
    num? price,
    num? ch,
    num? chp,
    num? ask,
    num? bid,
    num? priceGram24K,
    num? priceGram22K,
    num? priceGram21K,
    num? priceGram20K,
    num? priceGram18K,
    num? priceGram16K,
    num? priceGram14K,
    num? priceGram10K,
  }) =>
      MetalWorldPriceModel(
        timestamp: timestamp ?? this.timestamp,
        metal: metal ?? this.metal,
        currency: currency ?? this.currency,
        exchange: exchange ?? this.exchange,
        symbol: symbol ?? this.symbol,
        prevClosePrice: prevClosePrice ?? this.prevClosePrice,
        openPrice: openPrice ?? this.openPrice,
        lowPrice: lowPrice ?? this.lowPrice,
        highPrice: highPrice ?? this.highPrice,
        openTime: openTime ?? this.openTime,
        price: price ?? this.price,
        ch: ch ?? this.ch,
        chp: chp ?? this.chp,
        ask: ask ?? this.ask,
        bid: bid ?? this.bid,
        priceGram24K: priceGram24K ?? this.priceGram24K,
        priceGram22K: priceGram22K ?? this.priceGram22K,
        priceGram21K: priceGram21K ?? this.priceGram21K,
        priceGram20K: priceGram20K ?? this.priceGram20K,
        priceGram18K: priceGram18K ?? this.priceGram18K,
        priceGram16K: priceGram16K ?? this.priceGram16K,
        priceGram14K: priceGram14K ?? this.priceGram14K,
        priceGram10K: priceGram10K ?? this.priceGram10K,
      );

  factory MetalWorldPriceModel.fromJson(Map<String, dynamic> json) => _$MetalWorldPriceModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetalWorldPriceModelToJson(this);
}
