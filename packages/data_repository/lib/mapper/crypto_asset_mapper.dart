import 'package:data_network/model/crypto_asset_network_model.dart';
import 'package:domain_repository/entity/crypto_asset_entity.dart';

extension CryptoAssetNetworkMapper on CryptoAssetNetworkModel {
  CryptoAssetEntity toEntity() {
    return CryptoAssetEntity(
      id: id ?? '',
      rank: rank ?? '',
      symbol: symbol ?? '',
      name: name ?? '',
      supply: double.parse(supply ?? "0.0"),
      maxSupply: double.parse(maxSupply ?? "0.0"),
      marketCapUsd: double.parse(marketCapUsd ?? "0.0"),
      volumeUsd24Hr: double.parse(volumeUsd24Hr ?? "0.0"),
      priceUsd: double.parse(priceUsd ?? "0.0"),
      changePercent24Hr: double.parse(changePercent24Hr ?? "0.0"),
      vwap24Hr: double.parse(vwap24Hr ?? "0.0"),
      explorer: explorer ?? '',
      tokens: tokens ?? const {},
    );
  }
}
