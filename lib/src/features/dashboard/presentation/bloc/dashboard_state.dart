import 'package:equatable/equatable.dart';
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
  final bool isLoading;
  final String? errorMessage;

  const DashboardState({
    required this.metalType,
    required this.selectedRange,
    required this.data,
    required this.isLoading,
    this.errorMessage,
  });

  factory DashboardState.initial() {
    return const DashboardState(
      metalType: MetalType.gold,
      selectedRange: TimeRange.oneMonth,
      data: [],
      isLoading: false,
      errorMessage: null,
    );
  }

  DashboardState copyWith({
    MetalType? metalType,
    TimeRange? selectedRange,
    List<MetalChartData>? data,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DashboardState(
      metalType: metalType ?? this.metalType,
      selectedRange: selectedRange ?? this.selectedRange,
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        metalType,
        selectedRange,
        data,
        isLoading,
        errorMessage,
      ];
}
