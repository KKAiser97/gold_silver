import 'package:gold_silver/src/features/xchange_rate/domain/models/xchange_rate_model.dart';

abstract class ExchangeRateRepository {
  Future<ExchangeRateModel> getExchangeRate(String currencies);
}
