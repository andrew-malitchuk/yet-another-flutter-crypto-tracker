import 'package:data_network/source/api_source.dart';
import 'package:data_preference/source/preference_source.dart';
import 'package:data_repository/mapper/crypto_asset_mapper.dart';
import 'package:data_repository/mapper/data_response_mapper.dart';
import 'package:data_repository/mapper/history_mapper.dart';
import 'package:data_repository/mapper/user_profile_mapper.dart';
import 'package:domain_repository/entity/crypto_asset_entity.dart';
import 'package:domain_repository/entity/data_response_entity.dart';
import 'package:domain_repository/entity/history_entity.dart';
import 'package:domain_repository/entity/user_profile_entity.dart';
import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class CryptoRepositoryImpl extends CryptoRepository {
  ApiSource _apiSource;
  PreferenceSource _preferenceSource;

  CryptoRepositoryImpl(
    this._apiSource,
    this._preferenceSource,
  );

  @override
  Future<Result<DataResponseEntity<List<CryptoAssetEntity>>>> getAssets(
      String? search, int offset, int limit) async {
    return _apiSource
        .getAssets(search, offset, limit)
        .map((networkModel) => networkModel.toEntity(
              (model) => model.map((it) => it.toEntity()).toList(),
            ));
  }

  @override
  Future<Result<DataResponseEntity<CryptoAssetEntity>>> getAsset(String slug) {
    return _apiSource.getAsset(slug).map(
        (networkModel) => networkModel.toEntity((model) => model.toEntity()));
  }

  @override
  Future<Result<DataResponseEntity<HistoryEntity>>> getAssetHistory(
      String slug, String interval, String start, String end) {
    return _apiSource.getAssetHistory(slug, interval, start, end).map(
        (networkModel) => networkModel.toEntity((model) => model.toEntity()));
  }

  @override
  Future<Result<UserProfileEntity>> loadUserProfile() async {
    try {
      final profile = _preferenceSource.getProfile();
      if (profile != null) {
        return successOf(profile.toEntity());
      } else {
        return failureOf(Exception('Profile not found'));
      }
    } catch (e) {
      return failureOf(Exception(e));
    }
  }

  @override
  Future<Result<void>> saveUserProfile(UserProfileEntity? userProfile) async {
    try {
      if (userProfile == null) {
        await _preferenceSource.clearProfile();
      } else {
        await _preferenceSource.saveProfile(userProfile.toModel());
      }
      return successOf(unit);
    } catch (e) {
      return failureOf(Exception('Failed to save user profile: $e'));
    }
  }
}
