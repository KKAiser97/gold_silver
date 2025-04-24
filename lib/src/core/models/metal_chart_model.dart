class MetalChartData {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;

  MetalChartData({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  factory MetalChartData.fromMap(String dateStr, Map<String, dynamic> data) {
    return MetalChartData(
      date: DateTime.parse(dateStr),
      open: double.parse(data['1. open']),
      high: double.parse(data['2. high']),
      low: double.parse(data['3. low']),
      close: double.parse(data['4. close']),
    );
  }
}