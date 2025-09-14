import 'package:domain_repository/entity/user_profile_entity.dart';
import 'package:equatable/equatable.dart';

sealed class UserDetailsState extends Equatable {}

class UserDetailsInitialState extends UserDetailsState {
  @override
  List<Object?> get props => [];
}

class UserDetailsLoadingState extends UserDetailsState {
  @override
  List<Object?> get props => [];
}

class UserDetailsErrorState extends UserDetailsState {
  @override
  List<Object?> get props => [];
}

class UserDetailsValidationErrorState extends UserDetailsState {
  String errorMessage;

  UserDetailsValidationErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class UserDetailsLoadedState extends UserDetailsState {
  UserProfileEntity? userProfile;

  UserDetailsLoadedState([this.userProfile]);

  @override
  List<Object?> get props => [];
}

class UserDetailsDoneState extends UserDetailsState {
  @override
  List<Object?> get props => [];
}
