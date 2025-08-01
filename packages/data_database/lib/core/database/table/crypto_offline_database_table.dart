
import 'package:drift/drift.dart';

import '../../../model/crypto_asset_database_model.dart';
import '../app_database.dart';

class CryptoOfflineDatabaseTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().unique()();

  TextColumn get rank => text().nullable()();

  TextColumn get symbol => text().nullable()();

  RealColumn get supply => real().nullable()();

  RealColumn get maxSupply => real().nullable()();

  RealColumn get marketCapUsd => real().nullable()();

  RealColumn get volumeUsd24Hr => real().nullable()();

  RealColumn get priceUsd => real().nullable()();

  RealColumn get changePercent24Hr => real().nullable()();

  RealColumn get vwap24Hr => real().nullable()();

  TextColumn get explorer => text().nullable()();

  BlobColumn get tokens => blob().nullable()();

  RealColumn get amount => real().nullable()();
}

extension CryptoOfflineMapper on CryptoOfflineDatabaseTableData {
  CryptoAssetDatabaseModel toCryptoAsset() => CryptoAssetDatabaseModel(
      id: id,
      rank: rank ?? "",
      symbol: symbol ?? '',
      name: name,
      supply: supply ?? 0.0,
      maxSupply: maxSupply ?? 0.0,
      marketCapUsd: marketCapUsd ?? 0.0,
      volumeUsd24Hr: volumeUsd24Hr ?? 0.0,
      priceUsd: priceUsd ?? 0.0,
      changePercent24Hr: changePercent24Hr ?? 0.0,
      vwap24Hr: vwap24Hr ?? 0.0,
      explorer: explorer ?? '',
      tokens: {},
      amount: amount ?? 1.0);
}
