import 'package:equatable/equatable.dart';

sealed class UserProfileState extends Equatable {}

class UserProfileInitialState extends UserProfileState {
  @override
  List<Object?> get props => [];
}

class UserProfileLoadingState extends UserProfileState {
  @override
  List<Object?> get props => [];
}

class UserProfileErrorState extends UserProfileState {
  @override
  List<Object?> get props => [];
}

class UserProfileEmpty extends UserProfileState {
  @override
  List<Object?> get props => [];
}

class UserProfileLoadedState extends UserProfileState {
  String? data;
  String? avatar;

  UserProfileLoadedState(this.data, this.avatar);

  @override
  List<Object?> get props => [data, avatar];
}
