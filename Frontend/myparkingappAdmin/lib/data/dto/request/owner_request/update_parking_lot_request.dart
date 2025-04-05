// ignore_for_file: file_names
enum LotStatus { ON, OFF, FULL_SLOT }

class UpdateParkingLotRequest {
  String parkingLotName;
  String address;
  double latitude;   // Kinh độ
  double longitude;  // Vĩ độ
  String description;

  UpdateParkingLotRequest({
    required this.parkingLotName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.description,
  });
  /// **Chuyển từ `ParkingLotResponse` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "parkingLotName": parkingLotName,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
      "description": description,
    };
  }
}
