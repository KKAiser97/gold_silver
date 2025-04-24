import 'package:gold_silver/src/core/models/metal_model.dart';
import 'package:gold_silver/src/features/dashboard/data/datasource/dashboard_service.dart';
import 'package:gold_silver/src/features/dashboard/domain/dashboard_repository.dart';

class DashboardServiceRepositoryImpl implements MetalRepository {
  final DashboardService service;

  DashboardServiceRepositoryImpl(this.service);

  @override
  Future<MetalModel> getMetalData({
    required String function,
    required String symbol,
  }) {
    return service.getMetalData(function: function, symbol: symbol);
  }
}
