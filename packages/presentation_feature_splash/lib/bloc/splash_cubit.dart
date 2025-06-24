import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/configure/splash_configure.dart';

enum SplashStatus { initial, loading, error, goToUserDetails, goToMarket }

class SplashState {
  final SplashStatus status;

  const SplashState({required this.status});

  // TODO wtf
  factory SplashState.initial() => SplashState(status: SplashStatus.initial);
}

class SplashCubit extends Cubit<SplashState> {
  final CryptoRepository cryptoRepository;

  SplashCubit(this.cryptoRepository) : super(SplashState.initial());

  Future<void> initializeApp() async {
    emit(SplashState(status: SplashStatus.loading));

    try {
      // Simulate some initialization logic
      await Future.delayed(Duration(seconds: SplashConfigure.splashDuration));

      await cryptoRepository.loadUserProfile().then((it) {
        it.fold((onSuccess) {
          emit(SplashState(status: SplashStatus.goToMarket));
        }, (onFailure) {
          emit(SplashState(status: SplashStatus.goToUserDetails));
        });
      });
    } catch (e) {
      emit(SplashState(status: SplashStatus.error));
    }
  }
}
