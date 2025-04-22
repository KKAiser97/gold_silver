import 'package:equatable/equatable.dart';
import 'package:gold_silver/src/utils/enums.dart';

class MetalPricePoint {
  final DateTime time;
  final double value;

  MetalPricePoint({
    required this.time,
    required this.value,
  });
}

class DashboardState extends Equatable {
  final MetalType selectedMetal;
  final TimeRange selectedRange;
  final List<MetalPricePoint> dataPoints;
  final bool isLoading;
  final String? errorMessage;

  const DashboardState({
    required this.selectedMetal,
    required this.selectedRange,
    required this.dataPoints,
    required this.isLoading,
    this.errorMessage,
  });

  factory DashboardState.initial() {
    return const DashboardState(
      selectedMetal: MetalType.gold,
      selectedRange: TimeRange.oneMonth,
      dataPoints: [],
      isLoading: false,
      errorMessage: null,
    );
  }

  DashboardState copyWith({
    MetalType? selectedMetal,
    TimeRange? selectedRange,
    List<MetalPricePoint>? dataPoints,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DashboardState(
      selectedMetal: selectedMetal ?? this.selectedMetal,
      selectedRange: selectedRange ?? this.selectedRange,
      dataPoints: dataPoints ?? this.dataPoints,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    selectedMetal,
    selectedRange,
    dataPoints,
    isLoading,
    errorMessage,
  ];
}
