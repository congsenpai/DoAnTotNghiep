enum DiscountType {
  PERCENTAGE,
  FIXED,
}

class Discount {
  String discountId;
  String discountCode;
  DiscountType discountType;
  double discountValue;
  String description;

  Discount({
    required this.discountId,
    required this.discountCode,
    required this.discountType,
    required this.discountValue,
    required this.description,
  });

  // Convert from JSON
  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      discountId: json['discountId'],
      discountCode: json['discountCode'],
      discountType: DiscountType.values.firstWhere(
            (e) => e.toString().split('.').last == json['discountType'],
        orElse: () => DiscountType.FIXED, // default if not found
      ),
      discountValue: (json['discountValue'] as num).toDouble(),
      description: json['description'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'discountId': discountId,
      'discountCode': discountCode,
      'discountType': discountType.toString().split('.').last,
      'discountValue': discountValue,
      'description': description,
    };
  }
}
