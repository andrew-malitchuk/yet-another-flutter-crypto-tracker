import 'package:equatable/equatable.dart';

sealed class AccountSettingsState extends Equatable {}

class AccountSettingsInitialState extends AccountSettingsState {
  @override
  List<Object?> get props => [];
}

class AccountSettingsLoadedState extends AccountSettingsState {
  bool isBiometricEnabled;
  bool isNotificationEnabled;

  AccountSettingsLoadedState(
      this.isBiometricEnabled, this.isNotificationEnabled);

  @override
  List<Object?> get props => [isBiometricEnabled, isNotificationEnabled];

AccountSettingsLoadedState copyWith({
    bool? isBiometricEnabled,
    bool? isNotificationEnabled,
  }) {
    return AccountSettingsLoadedState(
      isBiometricEnabled ?? this.isBiometricEnabled,
      isNotificationEnabled ?? this.isNotificationEnabled,
    );
  }
}
