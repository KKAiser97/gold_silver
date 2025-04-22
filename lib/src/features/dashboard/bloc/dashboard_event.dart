import 'package:equatable/equatable.dart';
import 'package:gold_silver/src/utils/enums.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

/// Sự kiện khi người dùng chọn kim loại (vàng hoặc bạc)
class MetalToggled extends DashboardEvent {
  final MetalType metal;

  const MetalToggled(this.metal);

  @override
  List<Object?> get props => [metal];
}

/// Sự kiện khi người dùng chọn mốc thời gian
class TimeRangeSelected extends DashboardEvent {
  final TimeRange timeRange;

  const TimeRangeSelected(this.timeRange);

  @override
  List<Object?> get props => [timeRange];
}

/// Sự kiện khi app cần fetch dữ liệu từ API
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
