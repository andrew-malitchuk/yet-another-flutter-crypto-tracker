import 'package:data_network/core/network_route.dart';
import 'package:data_network/model/history_response_network_model.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../core/network_client.dart';
import '../core/network_configuration.dart';
import '../core/network_param.dart';
import '../model/crypto_asset_network_model.dart';
import '../model/data_response_network_model.dart';
import 'base/base_api_service.dart';

class ApiService extends BaseApiService {
  final NetworkClient _dioClient;

  ApiService(this._dioClient);

  /// Fetches a list of crypto assets from the API.
  ///
  /// [search] is an optional search query to filter assets.
  /// [offset] is the starting index for pagination.
  /// [limit] is the maximum number of assets to return.
  /// Returns a [Result] containing a [DataResponseNetworkModel] with a list of [CryptoAssetNetworkModel].
  Future<Result<DataResponseNetworkModel<List<CryptoAssetNetworkModel>>>>
      getAssets(String? search, int offset, int limit) async {
    return safeApiCall(() async {
      final response = await _dioClient.dioClient
          .getWithApiKey(NetworkRoute.listOfAssets(), queryParameters: {
        NetworkParam.search: search,
        NetworkParam.offset: offset,
        NetworkParam.limit: limit,
      });
      return DataResponseNetworkModel<List<CryptoAssetNetworkModel>>.fromJson(
        response.data,
        (json) => (json as List)
            .map((item) =>
                CryptoAssetNetworkModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    });
  }

  /// Fetches details of a single crypto asset by its [slug].
  ///
  /// Returns a [Result] containing a [DataResponseNetworkModel] with a [CryptoAssetNetworkModel].
  Future<Result<DataResponseNetworkModel<CryptoAssetNetworkModel>>> getAsset(
    String slug,
  ) async {
    return safeApiCall(() async {
      final response = await _dioClient.dioClient
          .getWithApiKey(NetworkRoute.assetDetails(slug));

      return DataResponseNetworkModel<CryptoAssetNetworkModel>.fromJson(
        response.data,
        (json) =>
            CryptoAssetNetworkModel.fromJson(json as Map<String, dynamic>),
      );
    });
  }

  /// Fetches the historical data of a crypto asset.
  ///
  /// [slug] is the identifier of the asset.
  /// [interval] specifies the time interval for the history (e.g., daily, hourly).
  /// [start] and [end] define the date range for the history.
  /// Returns a [Result] containing a [DataResponseNetworkModel] with a [HistoryResponseNetworkModel].
  Future<Result<DataResponseNetworkModel<HistoryResponseNetworkModel>>>
      getAssetHistory(
    String slug,
    String interval,
    String start,
    String end,
  ) async {
    return safeApiCall(() async {
      final response = await _dioClient.dioClient
          .getWithApiKey(NetworkRoute.assetHistory(slug), queryParameters: {
        NetworkParam.slug: slug,
        NetworkParam.interval: interval,
        NetworkParam.start: start,
        NetworkParam.end: end,
      });
      return DataResponseNetworkModel<HistoryResponseNetworkModel>.fromJson(
        response.data,
        (json) =>
            HistoryResponseNetworkModel.fromJson(json as Map<String, dynamic>),
      );
    });
  }
}
