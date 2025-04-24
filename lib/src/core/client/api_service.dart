import 'package:gold_silver/src/core/models/metal_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/query")
  Future<MetalModel> getMetalData({
    @Query("function") required String function,
    @Query("symbol") required String symbol,
    @Query("apikey") required String apiKey,
  });
}

// Usage example in your app:
// final dioClient = DioClient();
// final api = ApiService(dioClient.dio);