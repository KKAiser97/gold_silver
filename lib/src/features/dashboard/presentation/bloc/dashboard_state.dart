import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gold_silver/src/core/models/metal_chart_model.dart';
import 'package:gold_silver/src/utils/enums.dart';

// class MetalChartData {
//   final DateTime time;
//   final double value;
//
//   MetalChartData({
//     required this.time,
//     required this.value,
//   });
// }

class DashboardState extends Equatable {
  final MetalType metalType;
  final TimeRange selectedRange;
  final List<MetalChartData> data;
  final List<FlSpot> chartSpots;
  final double maxY;
  final double interval;
  final bool isLoading;
  final String? errorMessage;

  const DashboardState({
    required this.metalType,
    required this.selectedRange,
    required this.data,
    required this.chartSpots,
    required this.maxY,
    this.interval = 100,
    required this.isLoading,
    this.errorMessage,
  });

  factory DashboardState.initial() {
    return const DashboardState(
      metalType: MetalType.gold,
      selectedRange: TimeRange.oneYear,
      data: [],
      chartSpots: [],
      maxY: 0,
      interval: 100,
      isLoading: false,
      errorMessage: null,
    );
  }

  DashboardState copyWith({
    MetalType? metalType,
    TimeRange? selectedRange,
    List<MetalChartData>? data,
    List<FlSpot>? chartSpots,
    double? maxY,
    double? interval,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DashboardState(
      metalType: metalType ?? this.metalType,
      selectedRange: selectedRange ?? this.selectedRange,
      data: data ?? this.data,
      chartSpots: chartSpots ?? this.chartSpots,
      maxY: maxY ?? this.maxY,
      interval: interval ?? this.interval,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        metalType,
        selectedRange,
        data,
        chartSpots,
        maxY,
        isLoading,
        errorMessage,
      ];
}
