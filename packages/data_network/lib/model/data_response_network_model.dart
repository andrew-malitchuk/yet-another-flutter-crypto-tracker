import 'package:json_annotation/json_annotation.dart';

part 'data_response_network_model.g.dart';

/// Represents a generic data response model for network operations.
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
@JsonSerializable(genericArgumentFactories: true)
class DataResponseNetworkModel<T> {
  @JsonKey(name: 'timestamp')
  final int timestamp;
  @JsonKey(name: 'data')
  final T data;

  DataResponseNetworkModel({required this.timestamp, required this.data});

  factory DataResponseNetworkModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$DataResponseNetworkModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$DataResponseNetworkModelToJson(this, toJsonT);
}
