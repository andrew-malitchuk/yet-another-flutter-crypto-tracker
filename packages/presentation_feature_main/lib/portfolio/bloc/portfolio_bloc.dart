import 'package:domain_repository/entity/crypto_asset_entity.dart';
import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_feature_main/portfolio/bloc/portfolio_event.dart';
import 'package:presentation_feature_main/portfolio/bloc/portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final CryptoRepository cryptoRepository;
  List<CryptoAssetEntity> data = [];

  PortfolioBloc({required this.cryptoRepository})
      : super(PortfolioInitialState()) {
    on<PortfolioLoadEvent>((event, emit) async {
      emit(PortfolioLoadingState());

      final result = await cryptoRepository.loadAssets();
      final sumResult = await cryptoRepository.getAssetSum();
      final username = await cryptoRepository.loadUserProfile();

      await result.fold((success) async {
        data = success;
        if (data.isEmpty) {
          emit(PortfolioEmptyState());
          return;
        }
        emit(PortfolioLoadedState(
          List.unmodifiable(data),
          sumResult.getOrDefault("0.00"),
          username.getOrNull()?.firstName ?? "",
        ));
      }, (failure) async {
        emit(PortfolioErrorState());
      });
    });

    on<PortfolioDeleteAssetEvent>((event, emit) async {
      final result = await cryptoRepository.deleteAsset(event.id);

      // Only compute extras if delete succeeded (optional optimization).
      await result.fold((_) async {
        data.removeWhere((asset) =>
            asset.symbol == event.id); // check ID vs symbol, see note below
        if (data.isEmpty) {
          emit(PortfolioEmptyState());
          return;
        }
        final sumResult = await cryptoRepository.getAssetSum();
        final username = await cryptoRepository.loadUserProfile();
        emit(PortfolioLoadedState(
          List.from(data),
          sumResult.getOrDefault("0.00"),
          username.getOrNull()?.firstName ?? "",
        ));
      }, (failure) async {
        emit(PortfolioErrorState());
      });
    });

    on<PortfolioEditAssetEvent>((event, emit) async {
      // UI-only update: change the item in-memory and re-emit state. No DB calls.
      // Prefer updating the current state's list to keep it the source of truth for UI.
      final s = state;

      await cryptoRepository.saveAsset(event.assetEntity);

      if (s is PortfolioLoadedState) {
        // Replace the edited asset in the visible list
        final updated = s.data
            .map((a) => a.id == event.assetEntity.id ||
                    a.symbol == event.assetEntity.symbol
                ? event.assetEntity
                : a)
            .toList(growable: false);

        // Re-emit with the same sum & username (no recalculation)
        emit(PortfolioLoadedState(
          List.unmodifiable(updated),
          s.sum,
          s.username,
        ));
        return;
      }

      // Fallback: if we’re not in Loaded state, update the local cache and emit something reasonable.
      // (Adjust the key you match on if your canonical id is different.)
      data = data
          .map((a) => a.id == event.assetEntity.id ||
                  a.symbol == event.assetEntity.symbol
              ? event.assetEntity
              : a)
          .toList(growable: false);

      if (data.isEmpty) {
        emit(PortfolioEmptyState());
      } else {
        // If you don't have previous sum/username here, keep defaults.
        emit(PortfolioLoadedState(
          List.unmodifiable(data),
          "0.00",
          "",
        ));
      }
    });
  }
}
