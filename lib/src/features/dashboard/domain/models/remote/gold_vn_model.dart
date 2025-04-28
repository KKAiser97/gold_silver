import 'package:json_annotation/json_annotation.dart';

part 'gold_vn_model.g.dart';

@JsonSerializable()
class GoldVnModel {
  @JsonKey(name: "jewelry")
  final Jewelry jewelry;

  GoldVnModel({required this.jewelry});

  GoldVnModel copyWith({
    Jewelry? jewelry,
  }) =>
      GoldVnModel(jewelry: jewelry ?? this.jewelry);

  factory GoldVnModel.fromJson(Map<String, dynamic> json) => _$GoldVnModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoldVnModelToJson(this);
}

@JsonSerializable()
class Jewelry {
  @JsonKey(name: "dateTime")
  final String dateTime;
  @JsonKey(name: "prices")
  final List<Price> prices;

  Jewelry({
    this.dateTime = '',
    this.prices = const [],
  });

  Jewelry copyWith({
    String? dateTime,
    List<Price>? prices,
  }) =>
      Jewelry(
        dateTime: dateTime ?? this.dateTime,
        prices: prices ?? this.prices,
      );

  factory Jewelry.fromJson(Map<String, dynamic> json) => _$JewelryFromJson(json);

  Map<String, dynamic> toJson() => _$JewelryToJson(this);
}

@JsonSerializable()
class Price {
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "key")
  final String key;
  @JsonKey(name: "buy")
  final num buy;
  @JsonKey(name: "sell")
  final num sell;

  Price({
    this.name = '',
    this.key = '',
    this.buy = 0,
    this.sell = 0,
  });

  Price copyWith({
    String? name,
    String? key,
    num? buy,
    num? sell,
  }) =>
      Price(
        name: name ?? this.name,
        key: key ?? this.key,
        buy: buy ?? this.buy,
        sell: sell ?? this.sell,
      );

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}
