import 'package:domain_repository/entity/crypto_asset_entity.dart';
import 'package:domain_repository/entity/data_response_entity.dart';
import 'package:domain_repository/entity/history_entity.dart';
import 'package:result_dart/result_dart.dart';

import '../entity/user_profile_entity.dart';

abstract class CryptoRepository {
  Future<Result<DataResponseEntity<List<CryptoAssetEntity>>>> getAssets(
      String? search, int offset, int limit);

  Future<Result<DataResponseEntity<CryptoAssetEntity>>> getAsset(String slug);

  Future<Result<DataResponseEntity<HistoryEntity>>> getAssetHistory(
      String slug, String interval, String start, String end);


  Future<Result<UserProfileEntity>> loadUserProfile();

  Future<Result<void>> saveUserProfile(UserProfileEntity? userProfile);
}
