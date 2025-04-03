// ignore_for_file: file_names

class ParkingSlotResponse {
  String slotId;
  String slotName;
  String vehicleType;   // Loại xe (car, motorbike, etc.)
  String slotStatus;    // Trạng thái (available, occupied, reserved)
  double pricePerHour;  // Giá theo giờ
  double pricePerMonth; // Giá theo tháng
  String parkingLotId;  // Thuộc bãi đỗ nào

  ParkingSlotResponse({
    required this.slotId,
    required this.slotName,
    required this.vehicleType,
    required this.slotStatus,
    required this.pricePerHour,
    required this.pricePerMonth,
    required this.parkingLotId,
  });

  /// **Chuyển từ JSON sang `ParkingSlot` object**
  factory ParkingSlotResponse.fromJson(Map<String, dynamic> json) {
    return ParkingSlotResponse(
      slotId: json["slotId"] ?? '',
      vehicleType: json["vehicleType"] ?? 'car',
      slotStatus: json["slotStatus"] ?? 'available',
      pricePerHour: (json["pricePerHour"] ?? 0.0).toDouble(),
      pricePerMonth: (json["pricePerMonth"] ?? 0.0).toDouble(),
      parkingLotId: json["parkingLotId"] ?? '', slotName: json["slotName"],
    );
  }

  /// **Chuyển từ `ParkingSlot` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "slotId": slotId,
      "vehicleType": vehicleType,
      "slotStatus": slotStatus,
      "pricePerHour": pricePerHour,
      "pricePerMonth": pricePerMonth,
      "parkingLotId": parkingLotId,
      "slotName":slotName
    };
  }

  @override
  String toString() {
    return "ParkingSlot(slotId: $slotId, vehicleType: $vehicleType, status: $slotStatus, pricePerHour: $pricePerHour, parkingLotId: $parkingLotId)";
  }
}

/// **Danh sách mẫu các vị trí đỗ xe**
List<ParkingSlotResponse> parkingSlotList = [
  ParkingSlotResponse(
    slotId: "S001",
    vehicleType: "car",
    slotStatus: "available",
    pricePerHour: 20000.0,
    pricePerMonth: 1500000.0,
    parkingLotId: "PL001", slotName: 'A1',
  ),
  ParkingSlotResponse(
    slotId: "S002",
    vehicleType: "car",
    slotStatus: "occupied",
    pricePerHour: 20000.0,
    pricePerMonth: 1500000.0,
    parkingLotId: "PL001", slotName: 'A2',
  ),
  ParkingSlotResponse(
    slotId: "S003",
    vehicleType: "motorbike",
    slotStatus: "available",
    pricePerHour: 5000.0,
    pricePerMonth: 500000.0,
    parkingLotId: "PL002", slotName: 'A3',
  ),
  ParkingSlotResponse(
    slotId: "S004",
    vehicleType: "motorbike",
    slotStatus: "reserved",
    pricePerHour: 5000.0,
    pricePerMonth: 500000.0,
    parkingLotId: "PL002", slotName: 'A4',
  ),
];
