import 'package:data_preference/model/user_profile_prefernce_model.dart';
import 'package:hive/hive.dart';

class PreferenceSource {
  static const _key = 'user_profile';

  final Box<UserProfilePreferenceModel> _box;

  PreferenceSource(this._box);

  Future<void> saveProfile(UserProfilePreferenceModel profile) async {
    await _box.put(_key, profile);
  }

  UserProfilePreferenceModel? getProfile() {
    return _box.get(_key);
  }

  Future<void> clearProfile() async {
    await _box.delete(_key);
  }

  Future<void> updateEmail(String newEmail) async {
    final current = _box.get(_key);
    if (current != null) {
      final updated = UserProfilePreferenceModel(
        firstName: current.firstName,
        secondName: current.secondName,
        email: newEmail,
        phone: current.phone,
        avatar: current.avatar,
        dateOfBirth: current.dateOfBirth,
      );
      await _box.put(_key, updated);
    }
  }

  Future<void> updateAvatar(String avatar) async {
    final current = _box.get(_key);
    if (current != null) {
      var updated = UserProfilePreferenceModel(
        firstName: current.firstName,
        secondName: current.secondName,
        email: current.email,
        phone: current.phone,
        dateOfBirth: current.dateOfBirth,
        avatar: avatar
      );
      await _box.put(_key, updated);
    }
  }

  bool hasProfile() => _box.containsKey(_key);
}
