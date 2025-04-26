import 'package:gold_silver/src/core/client/dio_client.dart';
import 'package:gold_silver/src/features/dashboard/domain/models/metal_model.dart';
import 'package:gold_silver/src/features/dashboard/domain/models/metal_world_price_model.dart';
import 'package:gold_silver/src/utils/constants.dart';

abstract class DashboardService {
  Future<MetalModel> getMetalData({
    required String function,
    required String symbol,
  });

  Future<MetalWorldPriceModel> getCurrentWorldPrice({required String symbol});
}

class DashboardServiceImpl implements DashboardService {
  final AlphaDioClient alphaClient;
  final GoldDioClient goldClient;

  const DashboardServiceImpl({required this.alphaClient, required this.goldClient});

  @override
  Future<MetalModel> getMetalData({required String function, required String symbol}) async {
    final res = await alphaClient.dio.get('/query', queryParameters: {
      'function': function,
      'symbol': symbol,
      'apikey': AppConstant.apiKeyAlphaVantage,
    });
    return MetalModel.fromJson(res.data);
  }

  @override
  Future<MetalWorldPriceModel> getCurrentWorldPrice({required String symbol}) async {
    try {
      final res = await goldClient.dio.get('/api/$symbol/USD');
      return MetalWorldPriceModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
