// ignore_for_file: constant_identifier_names

enum DiscountType {
  PERCENTAGE,
  FIXED,
}
class DiscountResponse {
  String discountId;
  String discountCode;
  DiscountType discountType;
  double discountValue;
  String description;
  String expiredAt;
  String parkingLotId;// sau này bỏ
  DiscountResponse({
    required this.discountId,
    required this.discountCode,
    required this.discountType,
    required this.discountValue,
    required this.description,
    required this.parkingLotId,
    required this.expiredAt

  });

  // Convert from JSON
  factory DiscountResponse.fromJson(Map<String, dynamic> json) {
    return DiscountResponse(
      discountId: json['discountId'],
      discountCode: json['discountCode'],
      discountType: DiscountType.values.firstWhere(
            (e) => e.toString().split('.').last == json['discountType'],
        orElse: () => DiscountType.FIXED, // default if not found
      ),
      discountValue: (json['discountValue'] as num).toDouble(),
      description: json['description'],
      parkingLotId: '',
      expiredAt: json['expiredAt'],
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

List<DiscountResponse> discountDemo = [
  DiscountResponse(
      discountId: 'D001',
      discountCode: 'SALE10',
      discountType: DiscountType.PERCENTAGE,
      discountValue: 10.0,
      description: 'Giảm 10% cho khách hàng lần đầu tiên.',
      parkingLotId: 'PL001', expiredAt: ''
  ),
  DiscountResponse(
      discountId: 'D002',
      discountCode: 'HEALTH20',
      discountType: DiscountType.FIXED,
      discountValue: 2000.0,
      description: 'Giảm 2000đ cho mỗi lượt gửi xe của bệnh nhân.',
      parkingLotId: 'PL001', expiredAt: ''
  ),
  DiscountResponse(
      discountId: 'D003',
      discountCode: 'AIRPORT5',
      discountType: DiscountType.PERCENTAGE,
      discountValue: 5.0,
      description: 'Giảm 5% cho khách gửi xe dài hạn (trên 7 ngày).',
      parkingLotId: 'PL001', expiredAt: ''
  ),
  DiscountResponse(
      discountId: 'D001',
      discountCode: 'SALE10',
      discountType: DiscountType.PERCENTAGE,
      discountValue: 10.0,
      description: 'Giảm 10% cho khách hàng lần đầu tiên.',
      parkingLotId: 'PL001', expiredAt: ''
  ),
  DiscountResponse(
      discountId: 'D002',
      discountCode: 'HEALTH20',
      discountType: DiscountType.FIXED,
      discountValue: 2000.0,
      description: 'Giảm 2000đ cho mỗi lượt gửi xe của bệnh nhân.',
      parkingLotId: 'PL001', expiredAt: ''
  ),
  DiscountResponse(
      discountId: 'D003',
      discountCode: 'AIRPORT5',
      discountType: DiscountType.PERCENTAGE,
      discountValue: 5.0,
      description: 'Giảm 5% cho khách gửi xe dài hạn (trên 7 ngày).',
      parkingLotId: 'PL002', expiredAt: ''
  ),
  DiscountResponse(
      discountId: 'D001',
      discountCode: 'SALE10',
      discountType: DiscountType.PERCENTAGE,
      discountValue: 10.0,
      description: 'Giảm 10% cho khách hàng lần đầu tiên.',
      parkingLotId: 'PL002', expiredAt: ''
  ),
  DiscountResponse(
      discountId: 'D002',
      discountCode: 'HEALTH20',
      discountType: DiscountType.FIXED,
      discountValue: 2000.0,
      description: 'Giảm 2000đ cho mỗi lượt gửi xe của bệnh nhân.',
      parkingLotId: 'PL002', expiredAt: ''
  ),
  DiscountResponse(
      discountId: 'D003',
      discountCode: 'AIRPORT5',
      discountType: DiscountType.PERCENTAGE,
      discountValue: 5.0,
      description: 'Giảm 5% cho khách gửi xe dài hạn (trên 7 ngày).',
      parkingLotId: 'PL002', expiredAt: ''
  )



];
