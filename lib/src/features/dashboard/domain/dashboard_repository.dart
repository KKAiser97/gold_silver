import 'package:gold_silver/src/features/dashboard/domain/models/metal_model.dart';
import 'package:gold_silver/src/features/dashboard/domain/models/metal_world_price_model.dart';

abstract class MetalRepository {
  Future<MetalModel> getMetalData({required String function, required String symbol});

  Future<MetalWorldPriceModel> getCurrentWorldPrice({required String symbol});
}
