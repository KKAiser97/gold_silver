import 'package:gold_silver/src/core/models/metal_model.dart';

abstract class MetalRepository {
  Future<MetalModel> getMetalData({
    required String function,
    required String symbol,
  });
}
