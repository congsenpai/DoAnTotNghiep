import 'dart:collection';

class User {
  String username;
  String password;
  String firstName;
  String lastName;
  String email;
  String phone;
  String address;
  Set<String> roles;
  bool status;
  String avatar;
  DateTime createdDate;
  DateTime updatedDate;

  User({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.roles,
    required this.status,
    required this.avatar,
    required this.createdDate,
    required this.updatedDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      roles: HashSet<String>.from(json['roles'] ?? []),
      status: json['status'] ?? true,
      avatar: json['avatar'] ?? '',
      createdDate: DateTime.parse(json['createdDate'] ?? DateTime.now().toIso8601String()),
      updatedDate: DateTime.parse(json['updatedDate'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'roles': roles.toList(),
      'status': status,
      'avatar': avatar,
      'createdDate': createdDate.toIso8601String(),
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
