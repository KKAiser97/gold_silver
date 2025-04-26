import 'package:gold_silver/src/core/client/dio_client_base.dart';
import 'package:gold_silver/src/utils/constants.dart';

// class DioClient {
//   static final DioClient _instance = DioClient._internal();
//
//   factory DioClient() => _instance;
//
//   late Dio dio;
//
//   DioClient._internal() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: AppConstant.baseUrlAlpha,
//         connectTimeout: const Duration(seconds: 20),
//         receiveTimeout: const Duration(seconds: 20),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       ),
//     );
//
//     dio.interceptors.addAll([
//       LogInterceptor(
//         request: true,
//         requestBody: true,
//         responseBody: true,
//         error: true,
//       ),
//       InterceptorsWrapper(
//         onRequest: (options, handler) {
//           // Optional: may attach API key if it's common to all requests
//           // options.queryParameters['apikey'] = 'API_KEY';
//           return handler.next(options);
//         },
//         onResponse: (response, handler) {
//           // Log or modify response globally if needed
//           log("Res: [${response.statusCode}]: ${response.data}");
//           return handler.next(response);
//         },
//         onError: (DioException err, handler) {
//           // Global error handling
//           log("Error [${err.response?.statusCode}]: ${err.message}");
//
//           if (err.type == DioExceptionType.connectionTimeout ||
//               err.type == DioExceptionType.receiveTimeout ||
//               err.type == DioExceptionType.sendTimeout) {
//             log("Timeout error.");
//           } else if (err.type == DioExceptionType.badResponse) {
//             log("Server error: ${err.response?.data}");
//           } else if (err.type == DioExceptionType.unknown) {
//             log("No internet connection?");
//           }
//
//           return handler.next(err); // or handler.reject(err);
//         },
//       )
//     ]);
//   }
// }

class AlphaDioClient extends DioClientBase {
  AlphaDioClient() : super(baseUrl: AppConstant.baseUrlAlpha);
}

class GoldDioClient extends DioClientBase {
  GoldDioClient() : super(baseUrl: AppConstant.baseUrlGold, headers: {"x-access-token": AppConstant.apiKeyGoldApi});
}
