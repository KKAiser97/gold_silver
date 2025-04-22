import 'package:equatable/equatable.dart';
import 'package:gold_silver/src/utils/enums.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

/// Event user selects a metal type
class MetalToggled extends DashboardEvent {
  final MetalType metal;

  const MetalToggled(this.metal);

  @override
  List<Object?> get props => [metal];
}

/// Event user selects a time range on the chart
class TimeRangeSelected extends DashboardEvent {
  final TimeRange timeRange;

  const TimeRangeSelected(this.timeRange);

  @override
  List<Object?> get props => [timeRange];
}

/// Event when the user toggles between ounces and "chỉ"
class UnitToggled extends DashboardEvent {
  final bool isOz;

  const UnitToggled(this.isOz);

  @override
  List<Object?> get props => [isOz];
}

/// Event fetch data for the selected metal type and time range
class FetchMetalData extends DashboardEvent {
  final MetalType metal;
  final TimeRange timeRange;
  final bool isManual; // true nếu là người dùng bấm nút, false nếu là tự động sau 10 phút

  const FetchMetalData({
    required this.metal,
    required this.timeRange,
    this.isManual = false,
  });

  @override
  List<Object?> get props => [metal, timeRange, isManual];
}
