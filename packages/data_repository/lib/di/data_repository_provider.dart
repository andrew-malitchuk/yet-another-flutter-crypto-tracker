import 'package:data_database/source/crypto_asset_database_datasource.dart';
import 'package:data_database/source/crypto_offline_database_datasource.dart';
import 'package:data_network/source/api_source.dart';
import 'package:data_preference/source/preference_source.dart';
import 'package:data_repository/repository/crypto_repository_impl.dart';
import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:provider/provider.dart';

List<Provider> dataRepositoryProviders = [
  Provider<CryptoRepository>(
    create: (context) => CryptoRepositoryImpl(
        context.read<ApiSource>(),
        context.read<PreferenceSource>(),
        context.read<CryptoAssetDatabaseDatasource>(),
        context.read<CryptoOfflineDatabaseDatasource>()
    ),
  ),
];
