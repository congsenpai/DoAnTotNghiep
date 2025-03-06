class Images {
  final String url;
  final String imageId;
  final String parkingLotId;
  final String userId; // Sửa chữ hoa thành chữ thường theo quy chuẩn Dart

  Images({
    required this.url,
    required this.imageId,
    required this.parkingLotId,
    required this.userId,
  });

  // Chuyển đổi đối tượng thành Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'imageId': imageId,
      'parkingLotId': parkingLotId,
      'userId': userId,
    };
  }

  // Tạo đối tượng từ Map (JSON)
  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      url: json['url'],
      imageId: json['imageId'],
      parkingLotId: json['parkingLotId'],
      userId: json['userId'],
    );
  }
}
List<Images> imagesDemo = [
  Images(url: "https://via.placeholder.com/150", imageId: '1', parkingLotId: 'PL001', userId: 'U001'),
  Images(url: "https://via.placeholder.com/150", imageId: '2', parkingLotId: 'PL001', userId: 'U002'),
  Images(url: "https://via.placeholder.com/150", imageId: '3', parkingLotId: 'PL001', userId: 'U003'),
];