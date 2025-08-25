import 'package:equatable/equatable.dart';

sealed class AccountSettingsEvent extends Equatable {}

class AccountSettingsLoadEvent extends AccountSettingsEvent {
  AccountSettingsLoadEvent();

  @override
  List<Object?> get props => [];
}

class AccountSettingsChangeBiometricEvent extends AccountSettingsEvent {
  bool? isEnabled;

  AccountSettingsChangeBiometricEvent({this.isEnabled});

  @override
  List<Object?> get props => [isEnabled];
}


class AccountSettingsChangeNotificationEvent extends AccountSettingsEvent {
  bool? isEnabled;

  AccountSettingsChangeNotificationEvent({this.isEnabled});

  @override
  List<Object?> get props => [isEnabled];
}
