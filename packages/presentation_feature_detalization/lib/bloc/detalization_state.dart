import 'package:domain_repository/entity/crypto_asset_entity.dart';
import 'package:domain_repository/entity/history_entity.dart';
import 'package:equatable/equatable.dart';

sealed class DetalizationState extends Equatable {}

class DetalizationInitialState extends DetalizationState {
  @override
  List<Object?> get props => [];
}

class DetalizationLoadingState extends DetalizationState {
  @override
  List<Object?> get props => [];
}

class DetalizationErrorState extends DetalizationState {
  @override
  List<Object?> get props => [];
}

class DetalizationLoadedState extends DetalizationState {
  CryptoAssetEntity? data;
  List<HistoryEntity>? history;

  DetalizationLoadedState(this.data,this.history);

  @override
  List<Object?> get props => [data,history];
}

class DetalizationEmptyState extends DetalizationState {
  @override
  List<Object?> get props => [];
}
