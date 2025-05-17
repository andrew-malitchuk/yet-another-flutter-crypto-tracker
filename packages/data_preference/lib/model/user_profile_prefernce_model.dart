import 'package:hive/hive.dart';

import 'base/base_preference_model.dart';

part 'user_profile_prefernce_model.g.dart';

// TODO rename to UserProfilePreferenceModel
@HiveType(typeId: 0)
class UserProfile extends BasePreferenceModel {
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String secondName;
  @HiveField(2)
  String email;
  @HiveField(3)
  String phone;
  @HiveField(4)
  int dateOfBirth;

  UserProfile({
    required this.firstName,
    required this.secondName,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
  });
}
