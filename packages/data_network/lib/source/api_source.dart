import 'package:data_network/model/crypto_asset_network_model.dart';
import 'package:data_network/model/data_response_network_model.dart';
import 'package:data_network/service/api_service.dart';
import 'package:result_dart/result_dart.dart';

import '../model/history_response_network_model.dart';

class ApiSource {
  final ApiService _apiService;

  ApiSource(this._apiService);

  Future<Result<DataResponseNetworkModel<List<CryptoAssetNetworkModel>>>>
      getAssets(String? search, int offset, int limit) async {
    return _apiService.getAssets(search, offset, limit);
  }

  Future<Result<DataResponseNetworkModel<CryptoAssetNetworkModel>>> getAsset(
      String slug) async {
    return _apiService.getAsset(slug);
  }

  Future<Result<DataResponseNetworkModel<List<HistoryResponseNetworkModel>>>>
      getAssetHistory(
    String slug,
    String interval,
    String start,
    String end,
  ) async {
    return _apiService.getAssetHistory(slug, interval, start, end);
  }
}
