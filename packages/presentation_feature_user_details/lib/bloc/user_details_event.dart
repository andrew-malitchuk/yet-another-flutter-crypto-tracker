import 'package:equatable/equatable.dart';

sealed class UserDetailsEvent extends Equatable {}

class UserDetailsLoadEvent extends UserDetailsEvent {
  @override
  List<Object?> get props => [];
}

class UserDetailsSaveEvent extends UserDetailsEvent {
  final String firstName;
  final String secondName;
  final String email;
  final String operator;
  final String phone;
  final int dateOfBirth;

  UserDetailsSaveEvent(this.firstName, this.secondName, this.email,
      this.operator, this.phone, this.dateOfBirth);

  bool isValid() {
    return firstName.isNotEmpty &&
        secondName.isNotEmpty &&
        email.isNotEmpty &&
        phone.isNotEmpty &&
        dateOfBirth > 0;
  }

  @override
  List<Object?> get props => [
        firstName,
        secondName,
        email,
        phone,
        dateOfBirth,
      ];
}
