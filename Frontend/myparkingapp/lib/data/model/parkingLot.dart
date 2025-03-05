// ignore_for_file: file_names, constant_identifier_names, camel_case_types
enum lotStatus {
  ON, OFF
}
class ParkingLot {
  String parkingLotId;
  String parkingLotName;
  String address;
  double latitude;   // Kinh độ
  double longitude;  // Vĩ độ
  int totalSlot;
  lotStatus status;
  double rate;
  String description;
  String userId;

  ParkingLot({
    required this.parkingLotId,
    required this.parkingLotName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.totalSlot,
    required this.status,
    required this.rate,
    required this.description,
    required this.userId,
  });

  /// **Chuyển từ JSON sang `ParkingLot` object**
  factory ParkingLot.fromJson(Map<String, dynamic> json) {
    return ParkingLot(
      parkingLotId: json["parkingLotId"] ?? '',
      parkingLotName: json["parkingLotName"] ?? '',
      address: json["address"] ?? '',
      latitude: (json["latitude"] ?? 0.0).toDouble(),
      longitude: (json["longitude"] ?? 0.0).toDouble(),
      totalSlot: json["totalSlot"] ?? 0,
      status: json["status"] ?? false,
      rate: (json["rate"] ?? 0.0).toDouble(),
      description: json["description"] ?? '',
      userId: json["userId"] ?? '',
    );
  }

  /// **Chuyển từ `ParkingLot` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "parkingLotId": parkingLotId,
      "parkingLotName": parkingLotName,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
      "totalSlot": totalSlot,
      "status": status,
      "rate": rate,
      "description": description,
      "userId": userId,
    };
  }

  @override
  String toString() {
    return "ParkingLot(parkingLotName: $parkingLotName, address: $address, totalSlot: $totalSlot, rate: $rate)";
  }
}

/// **Danh sách bãi đỗ xe mẫu**
List<ParkingLot> parkingLotList = [
  ParkingLot(
    parkingLotId: "PL001",
    parkingLotName: "Bãi đỗ xe trung tâm",
    address: "123 Đường ABC, Quận 1, TP.HCM",
    latitude: 10.7769,
    longitude: 106.7009,
    totalSlot: 100,
    status: lotStatus.ON,
    rate: 4.5,
    description: "Bãi đỗ xe an toàn, có mái che.",
    userId: "U001",
  ),
  // ParkingLot(
  //   parkingLotId: "PL002",
  //   parkingLotName: "Bãi đỗ xe Vincom",
  //   address: "456 Đường XYZ, Quận 2, TP.HCM",
  //   latitude: 10.7890,
  //   longitude: 106.7101,
  //   totalSlot: 150,
  //   status: lotStatus.ON,
  //   rate: 4.8,
  //   description: "Gần trung tâm thương mại, thuận tiện.",
  //   userId: "U001",
  // ),
  // ParkingLot(
  //   parkingLotId: "PL001",
  //   parkingLotName: "Bãi đỗ xe trung tâm",
  //   address: "123 Đường ABC, Quận 1, TP.HCM",
  //   latitude: 10.7769,
  //   longitude: 106.7009,
  //   totalSlot: 100,
  //   status: lotStatus.ON,
  //   rate: 4.5,
  //   description: "Bãi đỗ xe an toàn, có mái che.",
  //   userId: "U001",
  // ),
  // ParkingLot(
  //   parkingLotId: "PL002",
  //   parkingLotName: "Bãi đỗ xe Vincom",
  //   address: "456 Đường XYZ, Quận 2, TP.HCM",
  //   latitude: 10.7890,
  //   longitude: 106.7101,
  //   totalSlot: 150,
  //   status: lotStatus.ON,
  //   rate: 4.8,
  //   description: "Gần trung tâm thương mại, thuận tiện.",
  //   userId: "U001",
  // ),
  // ParkingLot(
  //   parkingLotId: "PL001",
  //   parkingLotName: "Bãi đỗ xe trung tâm",
  //   address: "123 Đường ABC, Quận 1, TP.HCM",
  //   latitude: 10.7769,
  //   longitude: 106.7009,
  //   totalSlot: 100,
  //   status: lotStatus.ON,
  //   rate: 4.5,
  //   description: "Bãi đỗ xe an toàn, có mái che.",
  //   userId: "U001",
  // ),
  // ParkingLot(
  //   parkingLotId: "PL002",
  //   parkingLotName: "Bãi đỗ xe Vincom",
  //   address: "456 Đường XYZ, Quận 2, TP.HCM",
  //   latitude: 10.7890,
  //   longitude: 106.7101,
  //   totalSlot: 150,
  //   status: lotStatus.ON,
  //   rate: 4.8,
  //   description: "Gần trung tâm thương mại, thuận tiện.",
  //   userId: "U001",
  // ),
  // ParkingLot(
  //   parkingLotId: "PL001",
  //   parkingLotName: "Bãi đỗ xe trung tâm",
  //   address: "123 Đường ABC, Quận 1, TP.HCM",
  //   latitude: 10.7769,
  //   longitude: 106.7009,
  //   totalSlot: 100,
  //   status: lotStatus.ON,
  //   rate: 4.5,
  //   description: "Bãi đỗ xe an toàn, có mái che.",
  //   userId: "U001",
  // ),
  // ParkingLot(
  //   parkingLotId: "PL002",
  //   parkingLotName: "Bãi đỗ xe Vincom",
  //   address: "456 Đường XYZ, Quận 2, TP.HCM",
  //   latitude: 10.7890,
  //   longitude: 106.7101,
  //   totalSlot: 150,
  //   status: lotStatus.ON,
  //   rate: 4.8,
  //   description: "Gần trung tâm thương mại, thuận tiện.",
  //   userId: "U001",
  // ),
];
