// Khai báo enum VehicleType
enum VehicleType {
  MOTORCYCLE,
  CAR,
  BICYCLE,
}

// Extension để dễ convert enum sang string và ngược lại
extension VehicleTypeExtension on VehicleType {
  String get name {
    switch (this) {
      case VehicleType.MOTORCYCLE:
        return 'MOTORCYCLE';
      case VehicleType.CAR:
        return 'CAR';
      case VehicleType.BICYCLE:
        return 'BICYCLE';
    }
  }

  static VehicleType fromString(String type) {
    switch (type.toUpperCase()) {
      case 'MOTORCYCLE':
        return VehicleType.MOTORCYCLE;
      case 'CAR':
        return VehicleType.CAR;
      case 'BICYCLE':
        return VehicleType.BICYCLE;
      default:
        throw Exception('Unknown VehicleType: $type');
    }
  }
}

// Class Vehicle
class Vehicle {
  String vehicleId;
  VehicleType vehicleType;
  String licensePlate;
  String description;

  Vehicle({
    required this.vehicleId,
    required this.vehicleType,
    required this.licensePlate,
    required this.description,
  });

  // Convert JSON to Vehicle object
  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      vehicleId: json['vehicleId'] as String,
      vehicleType: VehicleTypeExtension.fromString(json['vehicleType']),
      licensePlate: json['licensePlate'] as String,
      description: json['description'] as String,
    );
  }

  // Convert Vehicle object to JSON
  Map<String, dynamic> toJson() {
    return {
      'vehicleId': vehicleId,
      'vehicleType': vehicleType.name,
      'licensePlate': licensePlate,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Vehicle(vehicleId: $vehicleId, vehicleType: ${vehicleType.name}, licensePlate: $licensePlate, description: $description)';
  }
}
