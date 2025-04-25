// enum MetalType { gold, silver }
enum TimeRange { oneDay, oneWeek, oneMonth, threeMonth, halfYear, oneYear }

enum MetalType {
  gold('XAUUSD'),
  silver('XAGUSD');

  final String symbol;

  const MetalType(this.symbol);
}
