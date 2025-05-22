import 'package:gold_silver/src/features/xchange_rate/data/datasource/xchange_rate_service.dart';
import 'package:gold_silver/src/features/xchange_rate/domain/models/xchange_rate_model.dart';
import 'package:gold_silver/src/features/xchange_rate/domain/xchange_rate_repository.dart';

class ExchangeRateServiceRepositoryImpl implements ExchangeRateRepository {
  final ExchangeRateService service;

  ExchangeRateServiceRepositoryImpl(this.service);

  @override
  Future<ExchangeRateModel> getExchangeRate(String currencies) {
    return service.getExchangeRate(currencies);
  }
}
