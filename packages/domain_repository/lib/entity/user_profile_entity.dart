import 'base/base_entity.dart';

class UserProfileEntity extends BaseEntity {
  String firstName;
  String secondName;
  String email;
  String phone;
  int dateOfBirth;

  UserProfileEntity({
    required this.firstName,
    required this.secondName,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
  });

  bool isValid() {
    return firstName.isNotEmpty &&
        secondName.isNotEmpty &&
        email.isNotEmpty &&
        phone.isNotEmpty &&
        dateOfBirth > 0;
  }
}
