import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/core/models/metal_chart_model.dart';
import 'package:gold_silver/src/features/dashboard/domain/dashboard_repository.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:gold_silver/src/utils/constants.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  late final MetalRepository repository;

  DashboardBloc({required this.repository}) : super(DashboardState.initial()) {
    on<MetalToggled>(_onChangeMetalType);
    on<FetchMetalChartData>(_onFetchMetalChartData);
    on<TimeRangeSelected>(_onChangeTimeRange);
  }

  Future<void> _onFetchMetalChartData(FetchMetalChartData event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final response = await repository.getMetalData(
        function: AppConstant.timeSeries,
        symbol: state.metalType.symbol,
      );
      final data = response.data;
      List<MetalChartData> listData = [];
      if (data.containsKey("Time Series (Daily)")) {
        listData = parseChartData(data);
      } else {
        throw Exception("Invalid data format");
      }
      emit(state.copyWith(isLoading: false, data: listData));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  List<MetalChartData> parseChartData(Map<String, dynamic> json) {
    final timeSeries = json['Time Series (Daily)'] as Map<String, dynamic>;
    final List<MetalChartData> list = [];

    timeSeries.forEach((dateStr, data) {
      list.add(MetalChartData.fromMap(dateStr, data));
    });

    list.sort((a, b) => a.date.compareTo(b.date));

    return list;
  }

  void _onChangeMetalType(MetalToggled event, Emitter<DashboardState> emit) {
    emit(state.copyWith(metalType: event.metalType));
    add(FetchMetalChartData(metal: state.metalType, timeRange: state.selectedRange));
  }

  void _onChangeTimeRange(TimeRangeSelected event, Emitter<DashboardState> emit) {
    emit(state.copyWith(selectedRange: event.timeRange));
    add(FetchMetalChartData(metal: state.metalType, timeRange: state.selectedRange));
  }
}
