// ignore_for_file: non_constant_identifier_names


class CreateParkingOwnerRequest {
  final String username;
  final String password;
  final String phoneNumber;
  final String homeAddress;
  final String companyAddress;
  final String lastName;
  final String firstName;
  final String avatar;
  final String email;


  CreateParkingOwnerRequest( {
    required this.username,
    required this.password,
    required this.phoneNumber,
    required this.homeAddress,
    required this.companyAddress,
    required this.lastName,
    required this.firstName,
    required this.avatar,
    required this.email,
  });

  /// **Chuyển từ `User` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'phoneNumber': phoneNumber,
      'homeAddress': homeAddress,
      'companyAddress': companyAddress,
      'lastName': lastName,
      'firstName': firstName,
      'avatar': avatar,
      'email': email,
      'status': "ACTIVE",
      'roles': ['PARKING_OWNER']
    };
  }
  @override
  String toString() {
    return "User(username: $username, firstName: $firstName, lastName: $lastName, email: $email)";
  }
}

