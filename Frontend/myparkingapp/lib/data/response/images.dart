class Images {
  String url;

  Images({
    required this.url,
  });

  // Convert from JSON
  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
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
