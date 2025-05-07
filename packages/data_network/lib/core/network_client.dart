import 'package:dio/dio.dart';
import 'package:fancy_dio_inspector/fancy_dio_inspector.dart';

import 'network_configuration.dart';

class NetworkClient {
  NetworkClient() {
    _configureInterceptors();
  }

  final Dio dioClient = Dio(
    BaseOptions(
      baseUrl: NetworkConfiguration.baseUrl,
      connectTimeout: NetworkConfiguration.connectTimeout,
    ),
  );

  void _addInterceptor(Interceptor interceptor) {
    dioClient.interceptors.add(interceptor);
  }

  void _configureInterceptors() {
    _addInterceptor(LogInterceptor());
    _addInterceptor(FancyDioInterceptor());
  }
}

extension DioApiKeyExtension on Dio {
  Future<Response<T>> getWithApiKey<T>(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) {
    return get(
      path,
      data: data,
      queryParameters: {
        ...?queryParameters,
        'apiKey': NetworkConfiguration.apiKey,
      },
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }
}