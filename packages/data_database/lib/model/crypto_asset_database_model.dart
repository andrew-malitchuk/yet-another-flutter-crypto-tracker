import 'base/base_database_model.dart';

class CryptoAssetDatabaseModel extends BaseDatabaseModel {
  final int id;
  final String rank;
  final String symbol;
  final String name;
  final double supply;
  final double maxSupply;
  final double marketCapUsd;
  final double volumeUsd24Hr;
  final double priceUsd;
  final double changePercent24Hr;
  final double vwap24Hr;
  final String explorer;
  final Map<String, List<String>> tokens;
  final double amount;

  CryptoAssetDatabaseModel({
    required this.id,
    required this.rank,
    required this.symbol,
    required this.name,
    required this.supply,
    required this.maxSupply,
    required this.marketCapUsd,
    required this.volumeUsd24Hr,
    required this.priceUsd,
    required this.changePercent24Hr,
    required this.vwap24Hr,
    required this.explorer,
    required this.tokens,
    required this.amount,
  });
}
