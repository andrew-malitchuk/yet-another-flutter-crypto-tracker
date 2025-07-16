import 'package:domain_repository/entity/crypto_asset_entity.dart';
import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_feature_main/market/bloc/market_event.dart';
import 'package:presentation_feature_main/market/bloc/market_state.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final CryptoRepository cryptoRepository;

  List<CryptoAssetEntity> data = [];
  int initLoadOffset = 1;
  int currentOffset = 1;

  @override
  MarketState get initialState => MarketInitialState();

  MarketBloc({required this.cryptoRepository}) : super(MarketInitialState()) {
    on<MarketLoadEvent>((event, emit) async {
      emit(MarketLoadingState());

      // TODO remove this delay, it's just for demo purposes
      await Future.delayed(Duration(seconds: 2));

      final result = await cryptoRepository.getAssets(
          null,
          currentOffset,
          // TODO: fix
          10);

      result.fold((success) {
        data = success.data;
        if (data.isEmpty) {
          emit(MarketEmptyState());
          return;
        }
        emit(MarketLoadedState(data));
      }, (failure) {
        emit(MarketErrorState());
      });
    });
    on<MarketLoadMoreEvent>((event, emit) async {
      currentOffset += 10;

      // TODO remove this delay, it's just for demo purposes
      await Future.delayed(Duration(seconds: 2));

      final result = await cryptoRepository.getAssets(
          (state as MarketLoadedState?)?.query,
          currentOffset,
          // TODO: fix
          10);

      result.fold((success) {
        data += success.data;
        emit(MarketLoadedState(data));
      }, (failure) {
        emit(MarketErrorState());
      });
    });
    on<MarketSearchEvent>((event, emit) async {
      emit(MarketLoadingState());

      // Reset the offset and data for a new search
      initLoadOffset = 1;
      currentOffset = 1;

      // Perform the search with the provided query
      final result = await cryptoRepository.getAssets(
          event.query,
          currentOffset,
          // TODO: fix
          10);

      result.fold((success) {
        data = success.data;
        if (data.isEmpty) {
          emit(MarketEmptyState());
          return;
        } else {
          emit(MarketLoadedState(data)..query = event.query);
        }
      }, (failure) {
        emit(MarketErrorState());
      });
    });
  }
}
