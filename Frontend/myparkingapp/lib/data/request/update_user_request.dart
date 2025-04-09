import 'package:myparkingapp/data/response/images_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';

class UpdateUserRequest {
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

  UpdateUserRequest({
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
  });

  /// Convert User -> JSON
  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'username': username,
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
    return 'User(userId: $userID, username: $username, email: $email, phone: $phone, vehicles: ${vehicles.length})';
  }
}