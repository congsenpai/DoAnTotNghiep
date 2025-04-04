// ignore_for_file: non_constant_identifier_names

enum UserStatus { ACTIVE, INACTIVE, DELETED }

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
  final UserStatus status;
  final List<String> roles;

  UserResponse({
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

  /// **Chuyển từ JSON sang `UserResponse` object**
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      userId: json["userID"] ?? '',
      username: json["username"] ?? '',
      password: json["password"] ?? '',
      phoneNumber: json["phoneNumber"] ?? '',
      homeAddress: json["homeAddress"] ?? '',
      companyAddress: json["companyAddress"] ?? '',
      lastName: json["lastName"] ?? '',
      firstName: json["firstName"] ?? '',
      avatar: json["avatar"] ?? 'default-avatar.png',
      email: json["email"] ?? '',
      status: _parseUserStatus(json["status"]), // ✅ Chuyển từ String sang enum
      roles: List<String>.from(json["roles"] ?? []),
    );
  }

  /// **Chuyển từ `UserResponse` object sang JSON**
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
      'status': status.name, // ✅ Chuyển enum thành String
      'roles': roles, // ✅ Lưu danh sách roles đúng
    };
  }

  @override
  String toString() {
    return "User(username: $username, firstName: $firstName, lastName: $lastName, email: $email, status: $status)";
  }

  /// **Chuyển `String` thành `UserStatus`**
  static UserStatus _parseUserStatus(String? status) {
    switch (status?.toUpperCase()) {
      case "ACTIVE":
        return UserStatus.ACTIVE;
      case "INACTIVE":
        return UserStatus.INACTIVE;
      case "DELETED":
        return UserStatus.DELETED;
      default:
        return UserStatus.INACTIVE; // Giá trị mặc định nếu dữ liệu lỗi
    }
  }
}
