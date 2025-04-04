// ignore_for_file: constant_identifier_names

enum DiscountType { PERCENTAGE, FIXED }

class CreateDiscountResquest {
  String discountCode;
  DiscountType discountType;
  double discountValue;
  String description;

  CreateDiscountResquest({
    required this.discountCode,
    required this.discountType,
    required this.discountValue,
    required this.description,
  });

  /// **Chuyển từ `Discount` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "discountCode": discountCode,
      "discountType": discountType == DiscountType.PERCENTAGE ? "PERCENTAGE" : "FIXED",
      "discountValue": discountValue,
      "description": description,
    };
  }

  @override
  String toString() {
    return "discountCode: $discountCode, discountType: $discountType, discountValue: $discountValue";
  }
}