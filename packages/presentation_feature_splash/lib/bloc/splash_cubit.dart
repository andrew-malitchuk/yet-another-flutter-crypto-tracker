import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_core_platform/service/biometric_service.dart';

import '../core/configure/splash_configure.dart';



enum SplashStatus { initial, loading, error, goToUserDetails, goToMarket }

class SplashState {
  final SplashStatus status;

  const SplashState({required this.status});

  factory SplashState.initial() => SplashState(status: SplashStatus.initial);
}

class SplashCubit extends Cubit<SplashState> {
  final CryptoRepository cryptoRepository;
  final BiometricService biometricService;

  SplashCubit({
    required this.cryptoRepository,
    required this.biometricService,
  }) : super(SplashState.initial());

  Future<void> initializeApp() async {
    emit(SplashState(status: SplashStatus.loading));

    try {
      await Future.delayed(Duration(seconds: SplashConfigure.splashDuration));

      final isEnabled = await biometricService.isBiometricEnabled();

      if (isEnabled) {
        final didAuthenticate = await biometricService.authenticate();
        if (!didAuthenticate) {
          emit(SplashState(status: SplashStatus.error));
          return;
        }
      }

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
