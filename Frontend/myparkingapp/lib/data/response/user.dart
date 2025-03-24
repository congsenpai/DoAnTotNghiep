import 'package:myparkingapp/data/response/images.dart';
import 'package:myparkingapp/data/response/vehicle.dart';
import 'package:myparkingapp/data/response/wallet.dart';
class User {
  final String userID;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String homeAddress;
  final String companyAddress;
  final Images avatar;
  final List<Vehicle> vehicles;
  final List<Wallet> wallets;

  User({
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
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['userID'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      homeAddress: json['homeAddress'] as String,
      companyAddress: json['companyAddress'] as String,
      avatar: Images.fromJson(json['avatar']),
      vehicles: (json['vehicles'] as List<dynamic>)
          .map((item) => Vehicle.fromJson(item))
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
final User demoUser = User(
  userID: "U001",
  username: "john_doe",
  password: "123456",
  firstName: "John",
  lastName: "Doe",
  email: "john.doe@example.com",
  phone: "+123456789",
  homeAddress: "123 Main Street, Cityville",
  companyAddress: "456 Company Blvd, Worktown",
  avatar: Images(
    url: 'assets/images/Header-image.png',
  ),
  vehicles: [
    Vehicle(
      vehicleId: "V001",
      vehicleType: VehicleType.CAR,
      licensePlate: "ABC-1234",
      description: "Red Sedan Car",
    ),
    Vehicle(
      vehicleId: "V002",
      vehicleType: VehicleType.MOTORCYCLE,
      licensePlate: "XYZ-5678",
      description: "Black Motorcycle",
    ),
  ],
  wallets: [
    Wallet(
      walletId: "W001",
      balance: 150.75,
      currency: "USD",
      name: "Main Wallet", userId: 'U001',
    ),
    Wallet(
      walletId: "W002",
      balance: 50.00,
      currency: "USD",
      name: "Secondary Wallet", userId: 'U001',
    ),
  ],
);