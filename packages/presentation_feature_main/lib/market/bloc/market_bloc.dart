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
      await Future.delayed(const Duration(seconds: 2));

      final result = await cryptoRepository.getAssets(
        null,
        currentOffset,
        10,
      );

      await result.fold<Future<void>>(
        (success) async {
          if (emit.isDone) return;

          data = success.data;
          if (data.isEmpty) {
            emit(MarketEmptyState());
            return;
          }
          emit(MarketLoadedState(data));
        },
        (failure) async {
          final fromDbResult = await cryptoRepository.loadOfflineAssets(
            null,
            currentOffset,
            10,
          );

          if (emit.isDone) return;

          data = fromDbResult.getOrNull() ?? [];
          if (data.isEmpty) {
            emit(MarketEmptyState());
            return;
          }
          emit(MarketLoadedState(data));
        },
      );
    });

    const pageSize = 10;

    on<MarketLoadMoreEvent>((event, emit) async {
      final nextOffset = currentOffset + pageSize;

      await Future.delayed(const Duration(seconds: 2)); // demo delay

      final loaded =
          state is MarketLoadedState ? state as MarketLoadedState : null;
      final query = loaded?.query;

      final result = await cryptoRepository.getAssets(
        query,
        nextOffset,
        pageSize,
      );

      await result.fold<Future<void>>(
        (success) async {
          if (emit.isDone) return;

          final newItems = success.data;
          if (newItems.isEmpty) {
            return;
          }

          currentOffset = nextOffset;

          data = [...data, ...newItems];
          emit(MarketLoadedState(data));
        },
        (failure) async {
          final fromDbResult = await cryptoRepository.loadOfflineAssets(
            query,
            nextOffset,
            pageSize,
          );

          if (emit.isDone) return;

          final offlineItems = fromDbResult.getOrNull() ?? [];
          if (offlineItems.isEmpty) {
            return;
          }

          currentOffset = nextOffset;
          data = [...data, ...offlineItems];
          emit(MarketLoadedState(data));
        },
      );
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
          10);

      result.fold((success) {
        data = success.data;
        if (data.isEmpty) {
          emit(MarketEmptyState());
          return;
        } else {
          emit(MarketLoadedState(data)..query = event.query);
        }
      }, (failure) async {
        final fromDbResult = await cryptoRepository.loadOfflineAssets(
            event.query,
            currentOffset,
            10);
        data = fromDbResult.getOrNull() ?? [];
        if (data.isEmpty) {
          emit(MarketEmptyState());
          return;
        } else {
          emit(MarketLoadedState(data)..query = event.query);
        }
      });
    });
  }
}
