import 'package:gold_silver/src/core/client/dio_client.dart';
import 'package:gold_silver/src/core/models/metal_model.dart';
import 'package:gold_silver/src/utils/constants.dart';

abstract class DashboardService {
  Future<MetalModel> getMetalData({
    required String function,
    required String symbol,
  });
}

class DashboardServiceImpl implements DashboardService {
  final DioClient dioClient;

  const DashboardServiceImpl(this.dioClient);

  @override
  Future<MetalModel> getMetalData({required String function, required String symbol}) async {
    final res = await dioClient.dio.get('/query', queryParameters: {
      'function': function,
      'symbol': symbol,
      'apikey': AppConstant.apiKeyAlpha,
    });
    return MetalModel.fromJson(res.data);
  }
}
