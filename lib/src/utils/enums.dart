enum TimeRange { oneDay, oneWeek, oneMonth, threeMonth, halfYear, oneYear }

enum MetalType {
  gold('XAUUSD'),
  silver('XAGUSD');

  final String currency;

  const MetalType(this.currency);

  String get symbol {
    switch (this) {
      case MetalType.gold:
        return 'XAU';
      case MetalType.silver:
        return 'XAG';
    }
  }
}

enum Interval {
  gold(100),
  silver(10);

  final double value;

  const Interval(this.value);
}

enum MetalUnit {
  ounce('oz'),
  tael('tael');

  final String unit;

  const MetalUnit(this.unit);
}
