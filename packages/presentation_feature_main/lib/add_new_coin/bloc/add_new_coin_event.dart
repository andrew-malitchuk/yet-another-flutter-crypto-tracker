import 'package:domain_repository/entity/crypto_asset_entity.dart';
import 'package:equatable/equatable.dart';

sealed class AddNewCoinEvent extends Equatable {}

class AddNewCoinLoadEvent extends AddNewCoinEvent {
  @override
  List<Object?> get props => [];
}

class AddNewCoinSearchEvent extends AddNewCoinEvent {
  final String query;

  AddNewCoinSearchEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class AddNewCoinLoadMoreEvent extends AddNewCoinEvent {
  @override
  List<Object?> get props => [];
}

class SaveNewCoinSearchEvent extends AddNewCoinEvent {
  final CryptoAssetEntity assetEntity;

  SaveNewCoinSearchEvent(this.assetEntity);

  @override
  List<Object?> get props => [assetEntity];
}
