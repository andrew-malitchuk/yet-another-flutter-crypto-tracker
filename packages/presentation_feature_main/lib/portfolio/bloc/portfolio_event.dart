import 'package:domain_repository/entity/crypto_asset_entity.dart';
import 'package:equatable/equatable.dart';

sealed class PortfolioEvent extends Equatable {}

class PortfolioLoadEvent extends PortfolioEvent {
  @override
  List<Object?> get props => [];
}

class PortfolioDeleteAssetEvent extends PortfolioEvent {
  final String id;

  PortfolioDeleteAssetEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class PortfolioEditAssetEvent extends PortfolioEvent {
  final CryptoAssetEntity assetEntity;

  PortfolioEditAssetEvent(this.assetEntity);

  @override
  List<Object?> get props => [];
}
