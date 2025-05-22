import 'package:gold_silver/src/core/client/dio_client.dart';
import 'package:gold_silver/src/features/xchange_rate/domain/models/xchange_rate_model.dart';
import 'package:gold_silver/src/utils/constants.dart';

abstract class ExchangeRateService {
  Future<ExchangeRateModel> getExchangeRate(String currencies);
}

class ExchangeRateServiceImpl implements ExchangeRateService {
  final ExchangeRateDioClient client;

  ExchangeRateServiceImpl(this.client);

  @override
  Future<ExchangeRateModel> getExchangeRate(String currencies) async {
    try {
      final news = await client.dio.get('live', queryParameters: {
        'access_key': AppConstant.apiKeyExRate,
        'currencies': currencies,
      });
      return ExchangeRateModel.fromJson(news.data);
    } catch (e) {
      rethrow;
    }
  }
}
