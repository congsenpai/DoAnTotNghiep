class ImagesResponse {
  String url;

  ImagesResponse({
    required this.url,
  });

  // Convert from JSON
  factory ImagesResponse.fromJson(Map<String, dynamic> json) {
    return ImagesResponse(
      url: json['url'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}
