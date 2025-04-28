import 'package:equatable/equatable.dart';
import 'package:gold_silver/src/utils/enums.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

/// Event user selects a metal type
class MetalToggled extends DashboardEvent {
  final MetalType metalType;

  const MetalToggled({this.metalType = MetalType.gold});

  @override
  List<Object?> get props => [metalType];
}

/// Event user selects a time range on the chart
class TimeRangeSelected extends DashboardEvent {
  final TimeRange timeRange;

  const TimeRangeSelected(this.timeRange);

  @override
  List<Object?> get props => [timeRange];
}

/// Event when the user toggles between ounces and "lượng (tael)"
class UnitToggled extends DashboardEvent {
  final MetalUnit metalUnit;

  const UnitToggled(this.metalUnit);

  @override
  List<Object?> get props => [metalUnit];
}

/// Event fetch data for the selected metal type and time range
class FetchMetalChartData extends DashboardEvent {
  final MetalType metal;
  final TimeRange timeRange;
  final bool willUpdate;
  final bool isManual; // true nếu là người dùng bấm nút, false nếu là tự động sau 10 phút

  const FetchMetalChartData({
    required this.metal,
    required this.timeRange,
    this.willUpdate = true,
    this.isManual = false,
  });

  @override
  List<Object?> get props => [metal, timeRange, isManual];
}

/// Event fetch current price for the selected metal
class FetchCurrentPrice extends DashboardEvent {
  final MetalType metal;

  const FetchCurrentPrice(this.metal);

  @override
  List<Object?> get props => [metal];
}
