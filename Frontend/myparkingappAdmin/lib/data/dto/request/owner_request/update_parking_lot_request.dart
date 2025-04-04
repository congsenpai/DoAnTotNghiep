// ignore_for_file: file_names
enum LotStatus { ON, OFF, FULL_SLOT }

class UpdateParkingLotRequest {
  String parkingLotId;
  String parkingLotName;
  String address;
  double latitude;   // Kinh độ
  double longitude;  // Vĩ độ


  double rate;
  String description;

  UpdateParkingLotRequest({
    required this.parkingLotId,
    required this.parkingLotName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.rate,
    required this.description,
  });
  /// **Chuyển từ `ParkingLotResponse` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "parkingLotId": parkingLotId,
      "parkingLotName": parkingLotName,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
      "rate": rate,
      "description": description,
    };
  }
}
