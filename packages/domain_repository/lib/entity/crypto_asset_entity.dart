import '../entity/base/base_entity.dart';

class CryptoAssetEntity extends BaseEntity {
  final String id;
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

  CryptoAssetEntity({
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
  });

}
