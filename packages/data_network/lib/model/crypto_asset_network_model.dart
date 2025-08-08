import 'package:json_annotation/json_annotation.dart';

import 'base/base_network_model.dart';

part 'crypto_asset_network_model.g.dart';

/// Represents a cryptocurrency asset model for network operations.
///
/// JSON example:
///
/// ```json
/// {
///   "timestamp": 1726081635506,
///   "data": [
///     {
///       "id": "bitcoin",
///       "rank": "1",
///       "symbol": "BTC",
///       "name": "Bitcoin",
///       "supply": "19752815.0000000000000000",
///       "maxSupply": "21000000.0000000000000000",
///       "marketCapUsd": "1134508584478.0989721079862315",
///       "volumeUsd24Hr": "7243846863.3409126543165751",
///       "priceUsd": "57435.2862859343831301",
///       "changePercent24Hr": "-0.0461491427646531",
///       "vwap24Hr": "57868.1484672081301126",
///       "explorer": "https://blockchain.info/werweqrerwerw",
///       "tokens": {
///         "1": [
///           "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2"
///         ],
///         "10": [
///           "0x4200000000000000000000000000000000000006"
///         ],
///         "137": [
///           "0x7ceb23fd6bc0add59e62ac25578270cff1b9f619"
///         ],
///         "42161": [
///           "0x82af49447d8a07e3bd95bd0d56f35241523fbab1"
///         ]
///       }
///     }
///   ]
/// }
/// ```
@JsonSerializable()
class CryptoAssetNetworkModel extends BaseNetworkModel {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'rank')
  final String? rank;
  @JsonKey(name: 'symbol')
  final String? symbol;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'supply')
  final String? supply;
  @JsonKey(name: 'maxSupply')
  final String? maxSupply;
  @JsonKey(name: 'marketCapUsd')
  final String? marketCapUsd;
  @JsonKey(name: 'volumeUsd24Hr')
  final String? volumeUsd24Hr;
  @JsonKey(name: 'priceUsd')
  final String? priceUsd;
  @JsonKey(name: 'changePercent24Hr')
  final String? changePercent24Hr;
  @JsonKey(name: 'vwap24Hr')
  final String? vwap24Hr;
  @JsonKey(name: 'explorer')
  final String? explorer;
  @JsonKey(name: 'tokens')
  final Map<String, List<String>>? tokens;

  CryptoAssetNetworkModel({
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

  factory CryptoAssetNetworkModel.fromJson(Map<String, dynamic> json) =>
      _$CryptoAssetNetworkModelFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoAssetNetworkModelToJson(this);
}
