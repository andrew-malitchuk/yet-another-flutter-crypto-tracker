import 'package:data_preference/model/user_profile_prefernce_model.dart';
import 'package:domain_repository/entity/user_profile_entity.dart';

extension UserProfileEntityMapper on UserProfile {
  UserProfileEntity toEntity() {
    return UserProfileEntity(
      firstName: firstName,
      secondName: secondName,
      email: email,
      phone: phone,
      dateOfBirth: dateOfBirth,
    );
  }
}

extension UserProfileModelMapper on UserProfileEntity {
  UserProfile toModel() {
    return UserProfile(
      firstName: firstName,
      secondName: secondName,
      email: email,
      phone: phone,
      dateOfBirth: dateOfBirth,
    );
  }
}
