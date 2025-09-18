import 'package:domain_repository/entity/user_profile_entity.dart';
import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_feature_user_profile/bloc/user_profile_event.dart';
import 'package:presentation_feature_user_profile/bloc/user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final CryptoRepository cryptoRepository;

  @override
  UserProfileState get initialState => UserProfileInitialState();

  UserProfileBloc({required this.cryptoRepository})
      : super(UserProfileInitialState()) {
    on<UserProfileLoadEvent>((event, emit) async {
      emit(UserProfileLoadingState());

      await Future.delayed(Duration(seconds: 2));

      final result = await cryptoRepository.loadUserProfile();

      result.fold((onSuccess) {
        if (onSuccess.firstName.isEmpty || onSuccess.secondName.isEmpty) {
          emit(UserProfileEmpty());
          return;
        }
        emit(UserProfileLoadedState(
            "${onSuccess.firstName} ${onSuccess.secondName}",
            onSuccess.avatar));
      }, (onFailure) {
        emit(UserProfileErrorState());
      });
    });
    on<UserProfileAvatarEvent>((event, emit) async {
      await cryptoRepository.saveUserAvatar(event.base64String);

      final currentState = state as UserProfileLoadedState;

      emit(UserProfileLoadedState(
          currentState.data,
          event.base64String));
    });
    on<UserProfileLogOutEvent>((event, emit) async {
      emit(UserProfileLoadingState());
      final result = await cryptoRepository.saveUserProfile(UserProfileEntity(
          firstName: "",
          secondName: "",
          email: "",
          phone: "",
          avatar: null,
          dateOfBirth: -1));
      result.fold((onSuccess) {
        emit(UserProfileEmpty());
      }, (onFailure) {
        emit(UserProfileErrorState());
      });
    });
  }
}
