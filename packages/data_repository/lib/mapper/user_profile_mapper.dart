import 'package:data_preference/model/user_profile_prefernce_model.dart';
import 'package:domain_repository/entity/user_profile_entity.dart';

extension UserProfileEntityMapper on UserProfilePreferenceModel {
  UserProfileEntity toEntity() {
    return UserProfileEntity(
      firstName: firstName,
      secondName: secondName,
      email: email,
      avatar: avatar,
      phone: phone,
      dateOfBirth: dateOfBirth,
    );
  }
}

extension UserProfileModelMapper on UserProfileEntity {
  UserProfilePreferenceModel toModel() {
    return UserProfilePreferenceModel(
      firstName: firstName,
      secondName: secondName,
      email: email,
      phone: phone,
      avatar: avatar,
      dateOfBirth: dateOfBirth,
    );
  }
}
