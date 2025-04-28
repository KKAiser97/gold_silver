import 'package:gold_silver/src/features/dashboard/data/datasource/dashboard_service.dart';
import 'package:gold_silver/src/features/dashboard/domain/dashboard_repository.dart';
import 'package:gold_silver/src/features/dashboard/domain/models/remote/gold_vn_model.dart';
import 'package:gold_silver/src/features/dashboard/domain/models/remote/metal_model.dart';
import 'package:gold_silver/src/features/dashboard/domain/models/remote/metal_world_price_model.dart';
import 'package:gold_silver/src/utils/enums.dart';

class DashboardServiceRepositoryImpl implements DashboardRepository {
  final DashboardService service;

  DashboardServiceRepositoryImpl(this.service);

  @override
  Future<MetalModel> getMetalData({required String function, required String symbol}) {
    return service.getMetalData(function: function, symbol: symbol);
  }

  @override
  Future<MetalWorldPriceModel> getCurrentWorldPrice({required String symbol}) {
    return service.getCurrentWorldPrice(symbol: symbol);
  }

  @override
  Future<GoldVnModel?> getGoldVnData(MetalType metal) {
    return service.getGoldVnData(metal);
  }
}
