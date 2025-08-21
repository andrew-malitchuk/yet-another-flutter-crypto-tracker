import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BiometricService {
  static const _key = 'biometric_enabled';
  final _auth = LocalAuthentication();

  Future<bool> canUseBiometrics() async {
    return await _auth.canCheckBiometrics && await _auth.isDeviceSupported();
  }

  Future<bool> authenticate() async {
    try {
      final result = await _auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      return result;
    } catch (e) {
      print('[ERROR] Biometric auth failed: $e');
      return false;
    }
  }

  Future<void> setBiometricEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, enabled);
  }

  Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }
}
