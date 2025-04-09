import 'dart:typed_data';

class ImagesResponse {
  String imageID;
  String? url;
  Uint8List? imageBytes;

  ImagesResponse(
    this.imageID, this.url, this.imageBytes
  );

  // Convert from JSON
  factory ImagesResponse.fromJson(Map<String, dynamic> json) {
    return ImagesResponse(
      json['imageID'] as String? ?? '',
      json['url'] as String? ?? '',
      null
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'imageID': imageID,
      'url': url,
    };
  }
}
