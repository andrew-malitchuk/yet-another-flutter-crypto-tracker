import 'package:domain_repository/entity/crypto_asset_entity.dart';
import 'package:equatable/equatable.dart';

sealed class MarketState extends Equatable {}

class MarketInitialState extends MarketState {
  @override
  List<Object?> get props => [];
}

class MarketLoadingState extends MarketState {
  @override
  List<Object?> get props => [];
}

class MarketErrorState extends MarketState {
  @override
  List<Object?> get props => [];
}

class MarketLoadedState extends MarketState {
  String? query;

  List<CryptoAssetEntity> data;

  MarketLoadedState(this.data);

  @override
  List<Object?> get props => [data, query];
}

class MarketEmptyState extends MarketState {
  @override
  List<Object?> get props => [];
}
