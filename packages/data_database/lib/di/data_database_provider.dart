import 'package:provider/provider.dart';

import '../core/database/app_database.dart';
import '../source/crypto_asset_database_datasource.dart';
import '../source/crypto_offline_database_datasource.dart';

List<Provider> dataDatabaseProviders = [
  Provider<AppDatabase>(
    create: (context) => AppDatabase(),
  ),
  Provider<CryptoAssetDatabaseDatasource>(
    create: (context) => CryptoAssetDatabaseDatasource(context.read<AppDatabase>()),
  ),
  Provider<CryptoOfflineDatabaseDatasource>(
    create: (context) => CryptoOfflineDatabaseDatasource(context.read<AppDatabase>()),
  ),
];
