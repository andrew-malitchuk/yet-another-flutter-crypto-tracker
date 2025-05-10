import 'package:dio/dio.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class BaseApiService {
  Future<Result<T>> safeApiCall<T extends Object>(
      Future<T> Function() apiCall) async {
    try {
      final result = await apiCall();
      return successOf(result);
    } on DioException catch (e) {
      return failureOf(e);
    }
  }
}
