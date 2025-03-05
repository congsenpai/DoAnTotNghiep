// ignore_for_file: file_names, constant_identifier_names, camel_case_types
import 'package:myparkingapp/data/model/vehicle.dart';

enum slotStatus {
  AVAILABLE, OCCUPIED, RESERVED
}

class ParkingSlot {
  String slotId;
  String slotName;
  VehicleType vehicleType;   // Loại xe (car, motorbike, etc.)
  slotStatus status;    // Trạng thái (available, occupied, reserved)
  double pricePerHour;  // Giá theo giờ
  double pricePerMonth; // Giá theo tháng
  String parkingLotId;
  String floorName;// Thuộc bãi đỗ nào

  ParkingSlot({
    required this.slotId,
    required this.slotName,
    required this.vehicleType,
    required this.status,
    required this.pricePerHour,
    required this.pricePerMonth,
    required this.parkingLotId,
    required this.floorName,
  });

  /// **Chuyển từ JSON sang `ParkingSlot` object**
  factory ParkingSlot.fromJson(Map<String, dynamic> json) {
    return ParkingSlot(
      slotId: json["slotId"] ?? '',
      vehicleType: json["vehicleType"] ?? 'car',
      status: json["slotStatus"] ?? 'available',
      pricePerHour: (json["pricePerHour"] ?? 0.0).toDouble(),
      pricePerMonth: (json["pricePerMonth"] ?? 0.0).toDouble(),
      parkingLotId: json["parkingLotId"] ?? '', slotName: json["slotName"], floorName: json["floorName"],
    );
  }

  /// **Chuyển từ `ParkingSlot` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "slotId": slotId,
      "vehicleType": vehicleType,
      "slotStatus": status,
      "pricePerHour": pricePerHour,
      "pricePerMonth": pricePerMonth,
      "parkingLotId": parkingLotId,
      "slotName":slotName,
      "floorName":floorName
    };
  }

  @override
  String toString() {
    return "ParkingSlot(slotId: $slotId, vehicleType: $vehicleType, status: $status, pricePerHour: $pricePerHour, parkingLotId: $parkingLotId)";
  }
}

/// **Danh sách mẫu các vị trí đỗ xe**
List<ParkingSlot> parkingSlotDemo = [
  ParkingSlot(
    slotId: "S001",
    vehicleType: VehicleType.CAR,
    status: slotStatus.AVAILABLE,
    pricePerHour: 20000.0,
    pricePerMonth: 1500000.0,
    parkingLotId: "PL001", slotName: 'A1', floorName: '1',
  ),
  ParkingSlot(
    slotId: "S002",
    vehicleType: VehicleType.CAR,
    status: slotStatus.AVAILABLE,
    pricePerHour: 20000.0,
    pricePerMonth: 1500000.0,
    parkingLotId: "PL001", slotName: 'A2', floorName: '1',
  ),
  ParkingSlot(
    slotId: "S003",
    vehicleType: VehicleType.CAR,
    status: slotStatus.AVAILABLE,
    pricePerHour: 5000.0,
    pricePerMonth: 500000.0,
    parkingLotId: "PL002", slotName: 'A3', floorName: '1',
  ),
  ParkingSlot(
    slotId: "S004",
    vehicleType: VehicleType.MOTORCYCLE,
    status: slotStatus.AVAILABLE,
    pricePerHour: 5000.0,
    pricePerMonth: 500000.0,
    parkingLotId: "PL002", slotName: 'A4', floorName: '1',
  ),
];
