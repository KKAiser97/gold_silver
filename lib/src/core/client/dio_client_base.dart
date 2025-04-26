import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

abstract class DioClientBase<T> {
  static const Duration _defaultTimeout = Duration(seconds: 30);
  static const String _formUrlEncodedContentType = 'application/json';
  late Dio dio;

  DioClientBase({
    required String baseUrl,
    List<Interceptor>? interceptors,
    Map<String, dynamic>? headers,
    Duration timeout = _defaultTimeout,
  }) {
    final option = BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      sendTimeout: timeout,
      connectTimeout: timeout,
      receiveTimeout: timeout,
      contentType: _formUrlEncodedContentType,
      responseType: ResponseType.json,
    );
    dio = Dio(option);
    dio.interceptors.addAll(interceptors ??
        [
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
    // dio.transformer = BackgroundTransformer()..jsonDecodeCallback = parseJson;
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        if (kDebugMode) {
          client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        }
        return client;
      },
    );
  }
}
