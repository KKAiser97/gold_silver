import 'package:gold_silver/src/core/client/dio_client.dart';
import 'package:gold_silver/src/features/dashboard/domain/models/remote/gold_vn_model.dart';
import 'package:gold_silver/src/features/dashboard/domain/models/remote/metal_model.dart';
import 'package:gold_silver/src/features/dashboard/domain/models/remote/metal_world_price_model.dart';
import 'package:gold_silver/src/utils/constants.dart';
import 'package:gold_silver/src/utils/enums.dart';

abstract class DashboardService {
  Future<MetalModel> getMetalData({
    required String function,
    required String symbol,
  });

  Future<MetalWorldPriceModel> getCurrentWorldPrice({required String symbol});

  Future<GoldVnModel?> getGoldVnData(MetalType metal);
}

class DashboardServiceImpl implements DashboardService {
  final AlphaDioClient alphaClient;
  final GoldDioClient goldClient;
  final DojiDioClient dojiClient;

  const DashboardServiceImpl({
    required this.alphaClient,
    required this.goldClient,
    required this.dojiClient,
  });

  @override
  Future<MetalModel> getMetalData({required String function, required String symbol}) async {
    final res = await alphaClient.dio.get('/query', queryParameters: {
      'function': function,
      'symbol': symbol,
      'apikey': AppConstant.apiKeyAlphaVantage,
    });
    return MetalModel.fromJson(res.data);
    // return MetalModel(metaData: MetaData(), data: {});
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

  @override
  Future<GoldVnModel?> getGoldVnData(MetalType metal) async {
    try {
      if (metal == MetalType.gold) {
        final res = await dojiClient.dio.get('/v1/gold-prices');
        return GoldVnModel.fromJson(res.data);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
