class Images {
  String imagesID;
  String url;

  Images({
    required this.imagesID,
    required this.url,
  });

  // Convert from JSON
  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      imagesID: json['imagesID'],
      url: json['url'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'imagesID': imagesID,
      'url': url,
    };
  }
}
