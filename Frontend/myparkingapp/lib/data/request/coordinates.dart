class Coordinates {
  double longitude;
  double latitude;

  Coordinates({required this.longitude, required this.latitude});

  // Chuyển từ JSON sang đối tượng Coordinates
  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      longitude: json['longitude'] as double,
      latitude: json['latitude'] as double,
    );
  }

  // Chuyển từ đối tượng Coordinates sang JSON
  Map<String, dynamic> toJson() {
    return {
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
