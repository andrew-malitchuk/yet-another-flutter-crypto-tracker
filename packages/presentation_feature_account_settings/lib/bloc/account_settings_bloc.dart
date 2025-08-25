import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_core_platform/service/biometric_service.dart';

import 'account_settings_event.dart';
import 'account_settings_state.dart';

import 'package:permission_handler/permission_handler.dart';


class AccountSettingsBloc
    extends Bloc<AccountSettingsEvent, AccountSettingsState> {
  final _service = BiometricService();
  final CryptoRepository cryptoRepository;

  @override
  AccountSettingsState get initialState => AccountSettingsInitialState();

  AccountSettingsBloc({required this.cryptoRepository})
      : super(AccountSettingsInitialState()) {
    on<AccountSettingsLoadEvent>(_onLoad);
    on<AccountSettingsChangeBiometricEvent>(_onChangeBiometric);
    on<AccountSettingsChangeNotificationEvent>(_onChangeNotifications);
  }

  Future<void> _onLoad(
      AccountSettingsLoadEvent event,
      Emitter<AccountSettingsState> emit,
      ) async {
    final isBiometricEnabled = await _service.isBiometricEnabled();

    // Query current notification status from OS
    final notifStatus = await Permission.notification.status;
    final isNotificationEnabled = _isNotifGranted(notifStatus);

    final currentState = state is AccountSettingsLoadedState
        ? state as AccountSettingsLoadedState
        : AccountSettingsLoadedState(false, false);

    emit(currentState.copyWith(
      isBiometricEnabled: isBiometricEnabled,
      isNotificationEnabled: isNotificationEnabled,
    ));
  }

  Future<void> _onChangeBiometric(
      AccountSettingsChangeBiometricEvent event,
      Emitter<AccountSettingsState> emit,
      ) async {
    final isBiometricEnabled = event.isEnabled ?? false;
    _service.setBiometricEnabled(isBiometricEnabled);

    final currentState = state is AccountSettingsLoadedState
        ? state as AccountSettingsLoadedState
        : AccountSettingsLoadedState(false, false);

    emit(currentState.copyWith(
      isBiometricEnabled: isBiometricEnabled,
      isNotificationEnabled: currentState.isNotificationEnabled,
    ));
  }

  Future<void> _onChangeNotifications(
      AccountSettingsChangeNotificationEvent event,
      Emitter<AccountSettingsState> emit,
      ) async {
    final wantEnable = event.isEnabled ?? false;

    final currentState = state is AccountSettingsLoadedState
        ? state as AccountSettingsLoadedState
        : AccountSettingsLoadedState(false, false);

    if (!wantEnable) {
      // Toggle OFF: just reflect it
      emit(currentState.copyWith(
        isNotificationEnabled: false,
        isBiometricEnabled: currentState.isBiometricEnabled,
      ));
      return;
    }

    // Toggle ON: request permission if not already granted
    var status = await Permission.notification.status;
    if (!_isNotifGranted(status)) {
      status = await Permission.notification.request();
    }

    final granted = _isNotifGranted(status);

    emit(currentState.copyWith(
      isNotificationEnabled: granted,
      isBiometricEnabled: currentState.isBiometricEnabled,
    ));

    // Optionally: if permanently denied, you could trigger a side-effect
    // (e.g., show UI prompt to open settings). Side-effects should be driven
    // from UI via a separate event; or expose a one-shot flag in state.
    // if (status.isPermanentlyDenied) {
    //   await openAppSettings();
    // }
  }

  bool _isNotifGranted(PermissionStatus status) =>
      status.isGranted || status.isLimited; // iOS may report limited
}
