import 'package:drift/drift.dart';

import '../core/database/app_database.dart';
import '../model/crypto_asset_database_model.dart';
import 'base/base_database_datasource.dart';

class CryptoAssetDatabaseDatasource
    extends BaseDatabaseDatasource<CryptoAssetDatabaseModel> {
  final AppDatabase _database;

  CryptoAssetDatabaseDatasource(this._database);

  @override
  Future<void> delete(int id) {
    return (_database.delete(_database.cryptoAssetDatabaseTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<void> deleteBySlug(String slug) {
    return (_database.delete(_database.cryptoAssetDatabaseTable)
          ..where((tbl) => tbl.symbol.equals(slug)))
        .go();
  }

  @override
  Future<void> deleteAll() {
    return (_database.delete(_database.cryptoAssetDatabaseTable)).go();
  }

  @override
  Future<List<CryptoAssetDatabaseModel>> getAll() {
    return _database
        .select(_database.cryptoAssetDatabaseTable)
        .get()
        .then((rows) {
      return rows
          .map((row) => CryptoAssetDatabaseModel(
                id: row.id,
                rank: row.rank ?? '',
                symbol: row.symbol ?? '',
                name: row.name ?? '',
                supply: row.supply ?? 0.0,
                maxSupply: row.maxSupply ?? 0.0,
                marketCapUsd: row.marketCapUsd ?? 0.0,
                volumeUsd24Hr: row.volumeUsd24Hr ?? 0.0,
                priceUsd: row.priceUsd ?? 0.0,
                changePercent24Hr: row.changePercent24Hr ?? 0.0,
                vwap24Hr: row.vwap24Hr ?? 0.0,
                explorer: row.explorer ?? '',
                tokens: {},
                amount: row.amount ?? 0.0,
              ))
          .toList();
    });
  }

  @override
  Future<CryptoAssetDatabaseModel?> getById(int id) {
    return (_database.select(_database.cryptoAssetDatabaseTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull()
        .then((row) {
      return row != null
          ? CryptoAssetDatabaseModel(
              id: row.id,
              rank: row.rank ?? '',
              symbol: row.symbol ?? '',
              name: row.name ?? '',
              supply: row.supply ?? 0.0,
              maxSupply: row.maxSupply ?? 0.0,
              marketCapUsd: row.marketCapUsd ?? 0.0,
              volumeUsd24Hr: row.volumeUsd24Hr ?? 0.0,
              priceUsd: row.priceUsd ?? 0.0,
              changePercent24Hr: row.changePercent24Hr ?? 0.0,
              vwap24Hr: row.vwap24Hr ?? 0.0,
              explorer: row.explorer ?? '',
              tokens: {},
              amount: row.amount ?? 1.0)
          : null;
    });
  }

  @override
  Future<void> insert(CryptoAssetDatabaseModel item) {
    return _database
        .into(_database.cryptoAssetDatabaseTable)
        .insertOnConflictUpdate(
          CryptoAssetDatabaseTableCompanion(
            name: Value(item.name),
            rank: Value(item.rank),
            symbol: Value(item.symbol),
            supply: Value(item.supply),
            maxSupply: Value(item.maxSupply),
            marketCapUsd: Value(item.marketCapUsd),
            volumeUsd24Hr: Value(item.volumeUsd24Hr),
            priceUsd: Value(item.priceUsd),
            changePercent24Hr: Value(item.changePercent24Hr),
            vwap24Hr: Value(item.vwap24Hr),
            explorer: Value(item.explorer),
            amount: Value(item.amount)
          ),
        );
  }

  @override
  Future<void> update(CryptoAssetDatabaseModel item) {
    return _database
        .update(_database.cryptoAssetDatabaseTable)
        .write(CryptoAssetDatabaseTableCompanion(
          name: Value(item.name),
        ));
  }

  @override
  Future<CryptoAssetDatabaseModel?> getBySlug(String slug) {
    return (_database.select(_database.cryptoAssetDatabaseTable)
          ..where((tbl) => tbl.symbol.equals(slug)))
        .getSingleOrNull()
        .then((row) {
      return row != null
          ? CryptoAssetDatabaseModel(
              id: row.id,
              rank: row.rank ?? '',
              symbol: row.symbol ?? '',
              name: row.name ?? '',
              supply: row.supply ?? 0.0,
              maxSupply: row.maxSupply ?? 0.0,
              marketCapUsd: row.marketCapUsd ?? 0.0,
              volumeUsd24Hr: row.volumeUsd24Hr ?? 0.0,
              priceUsd: row.priceUsd ?? 0.0,
              changePercent24Hr: row.changePercent24Hr ?? 0.0,
              vwap24Hr: row.vwap24Hr ?? 0.0,
              explorer: row.explorer ?? '',
              tokens: {},
              amount: row.amount ?? 1.0)
          : null;
    });
  }
// Implementation of the CryptoAssetDatabaseDataSource
// This class will handle the database operations related to CryptoAsset
}
