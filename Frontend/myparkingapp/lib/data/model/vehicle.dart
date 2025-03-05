// ignore_for_file: constant_identifier_names

enum VehicleType {
  MOTORCYCLE, CAR, BICYCLE
}
class Vehicle {
  final String vehicleId;
  final VehicleType vehicleType;
  String licensePlate;
  String description;
  String userId;

  Vehicle({
    required this.vehicleId,
    required this.vehicleType,
    required this.licensePlate,
    required this.description,
    required this.userId,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      vehicleId: json["vehicleId"] ?? '',
      vehicleType: VehicleType.values.firstWhere(
            (e) => e.toString().split('.').last == json['vehicleType'],
        orElse: () => VehicleType.CAR,
      ),
      licensePlate: json["licensePlate"] ?? '',
      description: json["description"] ?? '',
      userId: json["userId"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "vehicleId": vehicleId,
      "vehicleType": vehicleType.toString().split('.').last,
      "licensePlate": licensePlate,
      "description": description,
      "userId": userId,
    };
  }
}
