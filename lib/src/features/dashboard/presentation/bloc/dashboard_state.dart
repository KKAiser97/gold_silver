import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gold_silver/src/features/dashboard/domain/models/local/metal_chart_model.dart';
import 'package:gold_silver/src/utils/enums.dart';

class DashboardState extends Equatable {
  final MetalType metalType;
  final MetalUnit metalUnit;
  final TimeRange timeRange;
  final List<MetalChartData> data;
  final List<FlSpot> chartSpots;
  final double maxY;
  final double currentPrice;
  final double? currentDojiPrice;
  final double exchangeRate;
  final Interval interval;
  final bool isLoading;
  final bool isLoading2;
  final String? errorMessage;
  final String? errorMessage2;

  const DashboardState({
    required this.metalType,
    required this.metalUnit,
    required this.timeRange,
    required this.data,
    required this.chartSpots,
    required this.maxY,
    required this.currentPrice,
    this.currentDojiPrice,
    this.exchangeRate = 0,
    required this.interval,
    required this.isLoading,
    required this.isLoading2,
    this.errorMessage,
    this.errorMessage2,
  });

  factory DashboardState.initial() {
    return const DashboardState(
      metalType: MetalType.gold,
      metalUnit: MetalUnit.ounce,
      timeRange: TimeRange.oneYear,
      data: [],
      chartSpots: [],
      maxY: 0,
      currentPrice: 0,
      currentDojiPrice: null,
      exchangeRate: 0,
      interval: Interval.gold,
      isLoading: false,
      isLoading2: false,
      errorMessage: null,
      errorMessage2: null,
    );
  }

  int get currentPriceConvertToTael => (currentPrice * exchangeRate * 1.205).round(); // 1 lượng = 1.205oz

  DashboardState copyWith({
    MetalType? metalType,
    MetalUnit? metalUnit,
    TimeRange? timeRange,
    List<MetalChartData>? data,
    List<FlSpot>? chartSpots,
    double? maxY,
    double? currentPrice,
    double? currentDojiPrice,
    double? exchangeRate,
    Interval? interval,
    bool? isLoading,
    bool? isLoading2,
    String? errorMessage,
    String? errorMessage2,
  }) {
    return DashboardState(
      metalType: metalType ?? this.metalType,
      metalUnit: metalUnit ?? this.metalUnit,
      timeRange: timeRange ?? this.timeRange,
      data: data ?? this.data,
      chartSpots: chartSpots ?? this.chartSpots,
      maxY: maxY ?? this.maxY,
      currentPrice: currentPrice ?? this.currentPrice,
      currentDojiPrice: currentDojiPrice ?? this.currentDojiPrice,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      interval: interval ?? this.interval,
      isLoading: isLoading ?? this.isLoading,
      isLoading2: isLoading2 ?? this.isLoading2,
      errorMessage: errorMessage,
      errorMessage2: errorMessage2,
    );
  }

  @override
  List<Object?> get props => [
        metalType,
        metalUnit,
        timeRange,
        data,
        chartSpots,
        maxY,
        currentPrice,
        currentDojiPrice,
        exchangeRate,
        interval,
        isLoading,
        isLoading2,
        errorMessage,
        errorMessage2,
      ];
}
