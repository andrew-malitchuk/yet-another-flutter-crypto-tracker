import 'package:domain_repository/entity/crypto_asset_entity.dart';
import 'package:equatable/equatable.dart';

sealed class AddNewCoinState extends Equatable {}

class AddNewCoinInitialState extends AddNewCoinState {
  @override
  List<Object?> get props => [];
}

class AddNewCoinLoadingState extends AddNewCoinState {
  @override
  List<Object?> get props => [];
}

class AddNewCoinErrorState extends AddNewCoinState {
  @override
  List<Object?> get props => [];
}

class AddNewCoinLoadedState extends AddNewCoinState {
  String? query;

  List<CryptoAssetEntity> data;

  AddNewCoinLoadedState(this.data);

  @override
  List<Object?> get props => [data, query];
}

class AddNewCoinEmptyState extends AddNewCoinState {
  @override
  List<Object?> get props => [];
}

class SuccessAddNewCoinEmptyState extends AddNewCoinState {
  String? query;

  List<CryptoAssetEntity> data;

  SuccessAddNewCoinEmptyState(this.data);

  @override
  List<Object?> get props => [data, query];
}
