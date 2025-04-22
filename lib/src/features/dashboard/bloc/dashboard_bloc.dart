// import 'dart:async';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gold_silver/src/features/dashboard/bloc/dashboard_event.dart';
//
// part 'dashboard_event.dart';
// part 'dashboard_state.dart';
//
// class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
//   final ApiService apiService;
//
//   DashboardBloc({required this.apiService}) : super(DashboardInitial()) {
//     on<FetchChartData>(_onFetchChartData);
//   }
//
//   Future<void> _onFetchChartData(
//       FetchChartData event,
//       Emitter<DashboardState> emit,
//       ) async {
//     emit(DashboardLoading());
//     try {
//       final data = await apiService.getMetalChart(
//         metal: event.metal,
//         timeRange: event.timeRange,
//       );
//       emit(DashboardLoaded(chartData: data));
//     } catch (e) {
//       emit(DashboardError(message: e.toString()));
//     }
//   }
// }
