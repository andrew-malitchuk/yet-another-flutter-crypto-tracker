import 'package:equatable/equatable.dart';

sealed class UserProfileEvent extends Equatable {}

class UserProfileLoadEvent extends UserProfileEvent {
  UserProfileLoadEvent();

  @override
  List<Object?> get props => [];
}

class UserProfileAvatarEvent extends UserProfileEvent {
  String? base64String;

  UserProfileAvatarEvent({required this.base64String});

  @override
  List<Object?> get props => [base64String];
}

class UserProfileLogOutEvent extends UserProfileEvent {
  UserProfileLogOutEvent();

  @override
  List<Object?> get props => [];
}
