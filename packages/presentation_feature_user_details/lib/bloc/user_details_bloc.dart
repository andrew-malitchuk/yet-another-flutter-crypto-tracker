import 'package:domain_repository/entity/user_profile_entity.dart';
import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_feature_user_details/bloc/user_details_event.dart';
import 'package:presentation_feature_user_details/bloc/user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final CryptoRepository cryptoRepository;

  @override
  UserDetailsState get initialState => UserDetailsInitialState();

  UserDetailsBloc({required this.cryptoRepository})
      : super(UserDetailsInitialState()) {
    on<UserDetailsLoadEvent>((event, emit) async {
      emit(UserDetailsLoadingState());
      // TODO remove this delay, it's just for demo purposes
      await Future.delayed(Duration(seconds: 2));
      emit(UserDetailsLoadedState());
    });
    on<UserDetailsSaveEvent>((event, emit) async {
      emit(UserDetailsLoadingState());
      // TODO remove this delay, it's just for demo purposes
      // await Future.delayed(Duration(seconds: 10));

      switch (event.isValid()) {
        case true:
          _saveUserProfile(event);
          emit(UserDetailsLoadedState());
        case false:
          emit(
              UserDetailsValidationErrorState(errorMessage: 'errorValidation'));
      }
    });
  }

  void _saveUserProfile(UserDetailsSaveEvent event) async {
    await cryptoRepository
        .saveUserProfile(
        // UserProfileEntity(
        //     firstName: event.firstName,
        //     secondName: event.secondName,
        //     email: event.email,
        //     phone: event.operator + event.phone,
        //     dateOfBirth: event.dateOfBirth
        // ),
        UserProfileEntity(
            firstName:"",
            secondName: "",
            email: "",
            phone: "",
            dateOfBirth: -1
        ),
    )
        .then((it) {
      it.fold((onSuccess) {
        emit(UserDetailsDoneState());
      }, (onFailure) {
        emit(UserDetailsErrorState());
      });
    });
  }
}
