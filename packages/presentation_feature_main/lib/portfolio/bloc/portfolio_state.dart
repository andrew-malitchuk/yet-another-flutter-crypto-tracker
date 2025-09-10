import 'package:domain_repository/entity/crypto_asset_entity.dart';
import 'package:equatable/equatable.dart';

sealed class PortfolioState extends Equatable {}

class PortfolioInitialState extends PortfolioState {
  @override
  List<Object?> get props => [];
}

class PortfolioLoadingState extends PortfolioState {
  @override
  List<Object?> get props => [];
}

class PortfolioErrorState extends PortfolioState {
  @override
  List<Object?> get props => [];
}

class PortfolioLoadedState extends PortfolioState {
  List<CryptoAssetEntity> data;

  String sum;

  String username;

  PortfolioLoadedState(this.data, this.sum, this.username );

  @override
  List<Object?> get props => [
    // compare by each asset's symbol (or id) to detect deletions
    data.map((e) => e.priceUsd*(e.amount??1.0)).toList(),
    sum,
    username
  ];
}


class PortfolioEmptyState extends PortfolioState {
  @override
  List<Object?> get props => [];
}

