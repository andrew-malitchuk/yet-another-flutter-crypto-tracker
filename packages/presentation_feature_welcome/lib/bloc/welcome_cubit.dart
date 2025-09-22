import 'package:domain_repository/entity/user_profile_entity.dart';
import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum WelcomeStatus { initial, loading, error, goToUserDetails, goToMarket }

class WelcomeState {
  final WelcomeStatus status;

  const WelcomeState({required this.status});

  factory WelcomeState.initial() => WelcomeState(status: WelcomeStatus.initial);
}


class WelcomeCubit extends Cubit<WelcomeState> {
  final CryptoRepository cryptoRepository;

  WelcomeCubit(this.cryptoRepository) : super(WelcomeState.initial());

  Future<void> unauthorize() async {

    await cryptoRepository.saveUserProfile(
      UserProfileEntity(firstName: "", secondName: "", email: "", phone: "", dateOfBirth: -1, avatar: null)
    ).then((it){
      it.fold((onSuccess){
        emit(WelcomeState(status: WelcomeStatus.goToMarket));
      }, (onFailure){
        emit(WelcomeState(status: WelcomeStatus.error));
      });
    });

  }
}