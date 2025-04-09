import 'package:myparkingapp/data/response/images_response.dart';
import 'package:myparkingapp/data/response/vehicle__response.dart';
import 'package:myparkingapp/data/response/wallet__response.dart';
class UserResponse {
  final String userID;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String homeAddress;
  final String companyAddress;
  final ImagesResponse avatar;
  final List<VehicleResponse> vehicles;
  final List<WalletResponse> wallets; // will remove when project final

  UserResponse({
    required this.userID,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.homeAddress,
    required this.companyAddress,
    required this.avatar,
    required this.vehicles,
    required this.wallets,
  });

  /// Convert JSON -> User
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      userID: json['userID'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      homeAddress: json['homeAddress'] as String,
      companyAddress: json['companyAddress'] as String,
      avatar: ImagesResponse.fromJson(json['avatar']),
      vehicles: (json['vehicles'] as List<dynamic>)
          .map((item) => VehicleResponse.fromJson(item))
          .toList(),
      wallets: [],
    );
  }

  /// Convert User -> JSON
  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'username': username,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'homeAddress': homeAddress,
      'companyAddress': companyAddress,
      'avatar': avatar.toJson(),
      'vehicles': vehicles.map((v) => v.toJson()).toList(),
    };
  }

  /// Hỗ trợ debug dễ dàng
  @override
  String toString() {
    return 'User(userId: $userID, username: $username, email: $email, phone: $phone, vehicles: ${vehicles.length}, wallets: ${wallets.length})';
  }
}
final UserResponse demoUser = UserResponse(
  userID: "U001",
  username: "john_doe",
  password: "123456",
  firstName: "John",
  lastName: "Doe",
  email: "john.doe@example.com",
  phone: "+123456789",
  homeAddress: "123 Main Street, Cityville",
  companyAddress: "456 Company Blvd, Worktown",
  avatar: ImagesResponse(
    "",null,null
  ),
  vehicles: vehiclesdemo,
  wallets: walletdemo
);






