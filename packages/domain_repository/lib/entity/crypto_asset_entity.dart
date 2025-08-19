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
  final double? amount;

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
    required this.amount,
  });

  @override
  List<Object?> get props => [
        id,
        rank,
        symbol,
        name,
        supply,
        maxSupply,
        marketCapUsd,
        volumeUsd24Hr,
        priceUsd,
        changePercent24Hr,
        vwap24Hr,
        explorer,
        tokens,
        amount
      ];

CryptoAssetEntity copyWith({
    String? id,
    String? rank,
    String? symbol,
    String? name,
    double? supply,
    double? maxSupply,
    double? marketCapUsd,
    double? volumeUsd24Hr,
    double? priceUsd,
    double? changePercent24Hr,
    double? vwap24Hr,
    String? explorer,
    Map<String, List<String>>? tokens,
    double? amount,
  }) {
    return CryptoAssetEntity(
      id: id ?? this.id,
      rank: rank ?? this.rank,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      supply: supply ?? this.supply,
      maxSupply: maxSupply ?? this.maxSupply,
      marketCapUsd: marketCapUsd ?? this.marketCapUsd,
      volumeUsd24Hr: volumeUsd24Hr ?? this.volumeUsd24Hr,
      priceUsd: priceUsd ?? this.priceUsd,
      changePercent24Hr: changePercent24Hr ?? this.changePercent24Hr,
      vwap24Hr: vwap24Hr ?? this.vwap24Hr,
      explorer: explorer ?? this.explorer,
      tokens: tokens ?? this.tokens,
      amount: amount ?? this.amount,
    );
  }

}
