import 'package:domain_repository/entity/crypto_asset_entity.dart';
import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_new_coin_event.dart';
import 'add_new_coin_state.dart';

class AddNewCoinBloc extends Bloc<AddNewCoinEvent, AddNewCoinState> {
  final CryptoRepository cryptoRepository;

  List<CryptoAssetEntity> data = [];
  int initLoadOffset = 1;
  int currentOffset = 1;

  @override
  AddNewCoinState get initialState => AddNewCoinInitialState();

  AddNewCoinBloc({required this.cryptoRepository})
      : super(AddNewCoinInitialState()) {
    on<AddNewCoinLoadEvent>((event, emit) async {
      emit(AddNewCoinLoadingState());

      // TODO remove this delay, it's just for demo purposes
      await Future.delayed(Duration(seconds: 2));

      final result = await cryptoRepository.getAssets(
          null,
          currentOffset,
          10);

      result.fold((success) {
        data = success.data;
        if (data.isEmpty) {
          emit(AddNewCoinEmptyState());
          return;
        }
        emit(AddNewCoinLoadedState(data));
      }, (failure) {
        emit(AddNewCoinErrorState());
      });
    });
    on<AddNewCoinLoadMoreEvent>((event, emit) async {
      currentOffset += 10;

      // TODO remove this delay, it's just for demo purposes
      await Future.delayed(Duration(seconds: 2));

      final result = await cryptoRepository.getAssets(
          (state as AddNewCoinLoadedState?)?.query,
          currentOffset,
          10);

      result.fold((success) {
        data += success.data;
        emit(AddNewCoinLoadedState(data));
      }, (failure) {
        emit(AddNewCoinErrorState());
      });
    });
    on<AddNewCoinSearchEvent>((event, emit) async {
      emit(AddNewCoinLoadingState());

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
          emit(AddNewCoinEmptyState());
          return;
        } else {
          emit(AddNewCoinLoadedState(data)..query = event.query);
        }
      }, (failure) {
        emit(AddNewCoinErrorState());
      });
    });
    on<SaveNewCoinSearchEvent>((event, emit) async {
      final result = await cryptoRepository.saveAsset(event.assetEntity);

      final foo = await cryptoRepository.loadAssets();
      foo.toString();

      result.fold((success) {
        emit(SuccessAddNewCoinEmptyState(
            (state as AddNewCoinLoadedState?)?.data ?? []));
      }, (failure) {
        emit(AddNewCoinErrorState());
      });
    });
  }
}
