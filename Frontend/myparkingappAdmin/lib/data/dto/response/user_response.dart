// ignore_for_file: non_constant_identifier_names


class UserResponse {
  final String userId;
  final String username;
  final String password;
  final String phoneNumber;
  final String homeAddress;
  final String companyAddress;
  final String lastName;
  final String firstName;
  final String avatar;
  final String email;
  final bool status;
  final List<String> roles;

  UserResponse( {
    required this.userId,
    required this.username,
    required this.password,
    required this.phoneNumber,
    required this.homeAddress,
    required this.companyAddress,
    required this.lastName,
    required this.firstName,
    required this.avatar,
    required this.email,
    required this.status,
    required this.roles,
  });

  /// **Chuyển từ JSON sang `User` object**
    factory UserResponse.fromJson(Map<String, dynamic> json) {
      return UserResponse(
        username: json["username"] ?? '',
        password: json["password"] ?? '',
        phoneNumber: json["phoneNumber"] ?? '',
        homeAddress: json["homeAddress"] ?? '',
        companyAddress: json["companyAddress"] ?? '',
        lastName: json["lastName"] ?? '',
        firstName: json["firstName"] ?? '',
        avatar: json["avatar"] ?? 'default-avatar.png',
        email: json["email"] ?? '',
        status: json["status"] ?? false,
        userId: json["userID"] ?? '', roles: List<String>.from(json["roles"] ?? [])
      );
    }

  /// **Chuyển từ `User` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      'userID': userId,
      'username': username,
      'password': password,
      'phoneNumber': phoneNumber,
      'homeAddress': homeAddress,
      'companyAddress': companyAddress,
      'lastName': lastName,
      'firstName': firstName,
      'avatar': avatar,
      'email': email,
      'status': status,
      'roles':'roles'
    };
  }
  @override
  String toString() {
    return "User(username: $username, firstName: $firstName, lastName: $lastName, email: $email)";
  }
}

/// **Danh sách người dùng mẫu**
List<UserResponse> demoCustomersList = [
  UserResponse(
    userId: 'U000',
    username: 'john_doe',
    password: 'password123',
    phoneNumber: '123-456-7890',
    homeAddress: '123 Main St',
    companyAddress: '456 Business Blvd',
    lastName: 'Doe',
    firstName: 'John',
    avatar: 'assets/images/profile_pic.png',
    email: 'john.doe@example.com',
    status: true,
    roles: ['ADMIN'],
  ),
  UserResponse(
    userId: 'U001',
    username: 'john_doe1',
    password: 'password1231',
    phoneNumber: '123-456-7890',
    homeAddress: '123 Main St',
    companyAddress: '456 Business Blvd',
    lastName: 'Doe',
    firstName: 'John1',
    avatar: 'assets/images/profile_pic.png',
    email: 'john.doe@example.com',
    status: true,
    roles: ['OWNER'],
  ),
  UserResponse(
    userId: 'U002',
    username: 'john_doe2',
    password: 'password1231',
    phoneNumber: '123-456-7890',
    homeAddress: '123 Main St',
    companyAddress: '456 Business Blvd',
    lastName: 'Doe',
    firstName: 'John2',
    avatar: 'assets/images/profile_pic.png',
    email: 'john.doe@example.com',
    status: true,
    roles: ['OWNER'],
  ),
  UserResponse(
    userId: 'U003',
    username: 'john_doe3',
    password: 'password123',
    phoneNumber: '123-456-7890',
    homeAddress: '123 Main St',
    companyAddress: '456 Business Blvd',
    lastName: 'Doe',
    firstName: 'John',
    avatar: 'assets/images/profile_pic.png',
    email: 'john.doe@example.com',
    status: true,
    roles: ['CUSTOMER'],
  ),
  UserResponse(
    userId: 'U004',
    username: 'john_doe4',
    password: 'password123',
    phoneNumber: '123-456-7890',
    homeAddress: '123 Main St',
    companyAddress: '456 Business Blvd',
    lastName: 'Doe',
    firstName: 'John',
    avatar: 'assets/images/profile_pic.png',
    email: 'john.doe@example.com',
    status: true,
    roles: ['CUSTOMER'],
  ),

];

