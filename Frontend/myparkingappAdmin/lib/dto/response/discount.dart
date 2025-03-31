// ignore_for_file: constant_identifier_names

enum DiscountType { PERCENTAGE, FIXED }

class Discount {
  String discountId;
  String discountCode;
  DiscountType discountType;
  double discountValue;
  String description;
  String parkingLotId;

  Discount({
    required this.discountId,
    required this.discountCode,
    required this.discountType,
    required this.discountValue,
    required this.description,
    required this.parkingLotId,
  });

  /// **Chuyển từ JSON sang `Discount` object**
  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      discountId: json["discountId"] ?? '',
      discountCode: json["discountCode"] ?? '',
      discountType: json["discountType"] == "PERCENTAGE" ? DiscountType.PERCENTAGE : DiscountType.FIXED,
      discountValue: (json["discountValue"] ?? 0).toDouble(),
      description: json["description"] ?? '',
      parkingLotId: json["parkingLotId"] ?? '',
    );
  }
  /// **Chuyển từ `Discount` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "discountId": discountId,
      "discountCode": discountCode,
      "discountType": discountType == DiscountType.PERCENTAGE ? "PERCENTAGE" : "FIXED",
      "discountValue": discountValue,
      "description": description,
      "parkingLotId": parkingLotId,
    };
  }

  @override
  String toString() {
    return "Discount(discountId: $discountId,"
        " discountCode: $discountCode, discountType: $discountType, discountValue: $discountValue, parkingLotId: $parkingLotId)";
  }
}
List<Discount> demoDiscounts = [
  Discount(
    discountId: "D001",
    discountCode: "SAVE10",
    discountType: DiscountType.PERCENTAGE,
    discountValue: 10.0, // Giảm 10%
    description: "Giảm 10% cho đơn hàng đầu tiên",
    parkingLotId: "PL001",
  ),
  Discount(
    discountId: "PL001",
    discountCode: "FLAT50",
    discountType: DiscountType.FIXED,
    discountValue: 50000.0, // Giảm 50.000 VNĐ
    description: "Giảm 50.000 VNĐ cho đơn từ 500.000 VNĐ",
    parkingLotId: "P002",
  ),
];
