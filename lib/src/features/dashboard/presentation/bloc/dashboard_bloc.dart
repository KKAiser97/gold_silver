import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/features/dashboard/domain/dashboard_repository.dart';
import 'package:gold_silver/src/features/dashboard/domain/models/metal_chart_model.dart';
import 'package:gold_silver/src/features/dashboard/domain/models/metal_model.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:gold_silver/src/utils/constants.dart';
import 'package:gold_silver/src/utils/enums.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  late final MetalRepository repository;

  DashboardBloc({required this.repository}) : super(DashboardState.initial()) {
    on<MetalToggled>(_onChangeMetalType);
    on<FetchMetalChartData>(_onFetchMetalChartData);
    on<TimeRangeSelected>(_onChangeTimeRange);
    on<UnitToggled>(_onChangeUnit);
    on<FetchCurrentPrice>(_onFetchCurrentPrice);
  }

  Future<void> _onFetchCurrentPrice(FetchCurrentPrice event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(isLoading2: true, errorMessage2: null));

    try {
      final response = await repository.getCurrentWorldPrice(symbol: event.metal.symbol);
      emit(state.copyWith(isLoading2: false, currentPrice: response.price.toDouble()));
    } catch (e) {
      emit(state.copyWith(isLoading2: false, errorMessage2: e.toString()));
    }
  }

  Future<void> _onFetchMetalChartData(FetchMetalChartData event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final response = await repository.getMetalData(
        function: AppConstant.timeSeries,
        symbol: event.metal.currency,
      );
      final data = response.data;
      List<MetalChartData> listData = [];
      listData = _parseChartData(data);
      List<MetalChartData> currentList = _filterByRange(listData, event.timeRange);
      emit(state.copyWith(
        isLoading: false,
        data: currentList,
        chartSpots: _toChartSpots(currentList),
        maxY: _getMaxY(currentList),
        currentPrice: _getCurrentPrice(listData),
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  List<MetalChartData> _parseChartData(Map<String, TimeSeriesDaily> json) {
    final List<MetalChartData> list = [];
    json.forEach((dateStr, data) {
      list.add(MetalChartData.fromMap(dateStr, data));
    });
    list.sort((a, b) => a.date.compareTo(b.date));
    return list;
  }

  List<MetalChartData> _filterByRange(List<MetalChartData> allData, TimeRange range) {
    switch (range) {
      case TimeRange.oneWeek:
        return allData.reversed.take(7).toList().reversed.toList();
      case TimeRange.oneMonth:
        return allData.reversed.take(30).toList().reversed.toList();
      case TimeRange.threeMonth:
        return allData.reversed.take(90).toList().reversed.toList();
      case TimeRange.halfYear:
        return allData.reversed.take(180).toList().reversed.toList();
      default:
        return allData;
    }
  }

  List<FlSpot> _toChartSpots(List<MetalChartData> data) {
    return data
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.value.date.millisecondsSinceEpoch.toDouble(), entry.value.close))
        .toList();
  }

  double _getMaxY(List<MetalChartData> data) {
    final maxValue = data.map((e) => e.close).reduce((a, b) => a > b ? a : b);
    return (maxValue / state.interval.value).ceil() * state.interval.value;
  }

  double _getCurrentPrice(List<MetalChartData> data) {
    return data.last.close;
  }

  void _onChangeMetalType(MetalToggled event, Emitter<DashboardState> emit) {
    emit(state.copyWith(
        metalType: event.metalType, interval: event.metalType == MetalType.gold ? Interval.gold : Interval.silver));
    add(FetchMetalChartData(metal: state.metalType, timeRange: state.timeRange));
  }

  void _onChangeTimeRange(TimeRangeSelected event, Emitter<DashboardState> emit) {
    emit(state.copyWith(timeRange: event.timeRange));
    add(FetchMetalChartData(metal: state.metalType, timeRange: state.timeRange));
  }

  void _onChangeUnit(UnitToggled event, Emitter<DashboardState> emit) {
    emit(state.copyWith(metalUnit: event.metalUnit));
    // add(FetchMetalChartData(metal: state.metalType, timeRange: state.timeRange));
  }
}
