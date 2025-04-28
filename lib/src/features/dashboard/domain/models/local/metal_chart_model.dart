import 'package:gold_silver/src/features/dashboard/domain/models/remote/metal_model.dart';

class MetalChartData {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  MetalChartData({
    required this.date,
    this.open = 0,
    this.high = 0,
    this.low = 0,
    this.close = 0,
    this.volume = 0,
  });

  factory MetalChartData.fromMap(String dateStr, TimeSeriesDaily data) {
    return MetalChartData(
      date: DateTime.parse(dateStr),
      open: double.parse(data.open),
      high: double.parse(data.high),
      low: double.parse(data.low),
      close: double.parse(data.close),
    );
  }
}
