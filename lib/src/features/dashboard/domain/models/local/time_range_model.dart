import 'package:flutter/foundation.dart';
import 'package:gold_silver/src/utils/enums.dart';

class TimeRangeModel {
  TimeRange timeRange;

  ValueNotifier<bool> isSelected = ValueNotifier(false);

  TimeRangeModel({this.timeRange = TimeRange.oneYear});

  TimeRangeModel copyWith({TimeRange? timeRange, bool? isSelected2}) {
    return TimeRangeModel(timeRange: timeRange ?? this.timeRange);
  }
}
