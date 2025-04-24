import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gold_silver/src/utils/constants.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  late Dio dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstant.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Optional: may attach API key if it's common to all requests
          // options.queryParameters['apikey'] = 'API_KEY';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Log or modify response globally if needed
          log("Res: [${response.statusCode}]: ${response.data}");
          return handler.next(response);
        },
        onError: (DioException err, handler) {
          // Global error handling
          log("Error [${err.response?.statusCode}]: ${err.message}");

          if (err.type == DioExceptionType.connectionTimeout ||
              err.type == DioExceptionType.receiveTimeout ||
              err.type == DioExceptionType.sendTimeout) {
            log("Timeout error.");
          } else if (err.type == DioExceptionType.badResponse) {
            log("Server error: ${err.response?.data}");
          } else if (err.type == DioExceptionType.unknown) {
            log("No internet connection?");
          }

          return handler.next(err); // or handler.reject(err);
        },
      )
    ]);
  }
}

// class DioClient {
//   static final Dio dio = Dio(
//     BaseOptions(
//       baseUrl: AppConstant.baseUrl,
//       connectTimeout: const Duration(seconds: 30),
//       receiveTimeout: const Duration(seconds: 30),
//     ),
//   )..interceptors.addAll([
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
// }
