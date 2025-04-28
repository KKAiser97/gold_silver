import 'package:gold_silver/src/features/dashboard/domain/models/remote/gold_vn_model.dart';
import 'package:gold_silver/src/features/dashboard/domain/models/remote/metal_model.dart';
import 'package:gold_silver/src/features/dashboard/domain/models/remote/metal_world_price_model.dart';
import 'package:gold_silver/src/utils/enums.dart';

abstract class DashboardRepository {
  Future<MetalModel> getMetalData({required String function, required String symbol});

  Future<MetalWorldPriceModel> getCurrentWorldPrice({required String symbol});

  Future<GoldVnModel?> getGoldVnData(MetalType metal);
}
