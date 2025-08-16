import 'package:data_database/source/crypto_asset_database_datasource.dart';
import 'package:data_database/source/crypto_offline_database_datasource.dart';
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
  final ApiSource _apiSource;
  final PreferenceSource _preferenceSource;
  final CryptoAssetDatabaseDatasource _cryptoAssetDatabaseDatasource;
  final CryptoOfflineDatabaseDatasource _cryptoOfflineDatabaseDatasource;

  CryptoRepositoryImpl(
    this._apiSource,
    this._preferenceSource,
    this._cryptoAssetDatabaseDatasource,
    this._cryptoOfflineDatabaseDatasource,
  );

  @override
  Future<Result<DataResponseEntity<List<CryptoAssetEntity>>>> getAssets(
      String? search, int offset, int limit) async {
    final result = _apiSource
        .getAssets(search, offset, limit)
        .map((networkModel) => networkModel.toEntity(
              (model) => model.map((it) => it.toEntity()).toList(),
            ));

    result.map((list) => {
          list.data.forEach((it) {
            _cryptoOfflineDatabaseDatasource.insert(it.toModel());
          })
        });

    return result;
  }

  @override
  Future<Result<DataResponseEntity<CryptoAssetEntity>>> getAsset(String slug) {
    return _apiSource.getAsset(slug).map(
        (networkModel) => networkModel.toEntity((model) => model.toEntity()));
  }

  @override
  Future<Result<DataResponseEntity<List<HistoryEntity>>>> getAssetHistory(
      String slug, String interval, String start, String end) {
    return _apiSource.getAssetHistory(slug, interval, start, end).map(
        (networkModel) => networkModel
            .toEntity((model) => model.map((it) => it.toEntity()).toList()));
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

  @override
  Future<Result<void>> saveUserAvatar(String? avatar) async {
    try {
      if (avatar == null) {
        await _preferenceSource.clearProfile();
      } else {
        await _preferenceSource.updateAvatar(avatar);
      }
      return successOf(unit);
    } catch (e) {
      return failureOf(Exception('Failed to save user avatar: $e'));
    }
  }

  @override
  Future<Result<CryptoAssetEntity>> loadAsset(String slug) async {
    try {
      final asset = await _cryptoAssetDatabaseDatasource.getBySlug(slug);
      if (asset == null) {
        return failureOf(Exception('Asset not found'));
      }
      return successOf(asset.toEntity());
    } catch (e) {
      return failureOf(Exception('Failed to save user avatar: $e'));
    }
  }

  @override
  Future<Result<void>> saveAsset(CryptoAssetEntity? asset) async {
    try {
      if (asset == null && asset?.symbol != null) {
        await _cryptoAssetDatabaseDatasource.deleteBySlug(asset?.symbol ?? "");
      } else {
        await _cryptoAssetDatabaseDatasource.insert(asset!.toModel());
      }
      return successOf(unit);
    } catch (e) {
      return failureOf(Exception('Failed to save user avatar: $e'));
    }
  }

  @override
  Future<Result<List<CryptoAssetEntity>>> loadAssets() async {
    try {
      final assets = await _cryptoAssetDatabaseDatasource.getAll();
      return successOf((assets ?? []).map((it) => it.toEntity()).toList());
    } catch (e) {
      return failureOf(Exception('Failed to save user avatar: $e'));
    }
  }

  @override
  Future<Result<void>> deleteAsset(String id) async {
    try {
      await _cryptoAssetDatabaseDatasource.deleteBySlug(id);
      return successOf(unit);
    } catch (e) {
      return failureOf(Exception('Failed to save user avatar: $e'));
    }
  }

  @override
  Future<Result<String>> getAssetSum() async {
    try {
      final assets = await _cryptoAssetDatabaseDatasource.getAll();

      var sum = 0.0;
      for (var it in assets) {
        sum += (it.priceUsd * it.amount);
      }
      return successOf(sum.toStringAsFixed(2));
    } catch (e) {
      return failureOf(Exception('Failed to save user avatar: $e'));
    }
  }

  @override
  Future<Result<List<CryptoAssetEntity>>> loadOfflineAssets(
      String? search, int offset, int limit) async {
    try {
      final assets = await _cryptoOfflineDatabaseDatasource.loadAssets(
          search, offset, limit);
      return successOf(assets.map((it) => it.toEntity()).toList());
    } catch (e) {
      return failureOf(Exception('Failed to load offline assets: $e'));
    }
  }

  @override
  Future<Result<void>> saveOfflineAsset(CryptoAssetEntity? asset) async {
    try {
      if (asset == null && asset?.symbol != null) {
        await _cryptoOfflineDatabaseDatasource
            .deleteBySlug(asset?.symbol ?? "");
      } else {
        await _cryptoOfflineDatabaseDatasource.insert(asset!.toModel());
      }
      return successOf(unit);
    } catch (e) {
      return failureOf(Exception('Failed to save user avatar: $e'));
    }
  }

  @override
  Future<Result<CryptoAssetEntity>> loadOfflineAsset(String slug) async{
    try {
      final asset = await _cryptoOfflineDatabaseDatasource.getBySlug(slug);
      if (asset == null) {
        return failureOf(Exception('Asset not found'));
      }
      return successOf(asset.toEntity());
    } catch (e) {
      return failureOf(Exception('Failed to load offline assets: $e'));
    }
  }
}
