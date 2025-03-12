import 'discount.dart';
import 'images.dart';

enum LotStatus {
  ON,
  OFF,
  FULL_SLOT,
}

class ParkingLot {
  String parkingLotID;
  String parkingLotName;
  String address;
  double latitude;   // Kinh độ
  double longitude;  // Vĩ độ
  int totalSlot;
  LotStatus status;
  double rate;
  String description;
  List<Images> images;
  List<Discount> discounts;

  ParkingLot({
    required this.parkingLotID,
    required this.parkingLotName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.totalSlot,
    required this.status,
    required this.rate,
    required this.description,
    required this.images,
    required this.discounts,
  });

  // Convert from JSON
  factory ParkingLot.fromJson(Map<String, dynamic> json) {
    return ParkingLot(
      parkingLotID: json['parkingLotID'],
      parkingLotName: json['parkingLotName'],
      address: json['address'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      totalSlot: json['totalSlot'],
      status: LotStatus.values.firstWhere(
            (e) => e.toString().split('.').last == json['status'],
        orElse: () => LotStatus.OFF, // Default nếu không đúng
      ),
      rate: (json['rate'] as num).toDouble(),
      description: json['description'],
      images: (json['images'] as List<dynamic>)
          .map((item) => Images.fromJson(item))
          .toList(),
      discounts: (json['discounts'] as List<dynamic>)
          .map((item) => Discount.fromJson(item))
          .toList(),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'parkingLotID': parkingLotID,
      'parkingLotName': parkingLotName,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'totalSlot': totalSlot,
      'status': status.toString().split('.').last,
      'rate': rate,
      'description': description,
      'images': images.map((item) => item.toJson()).toList(),
      'discounts': discounts.map((item) => item.toJson()).toList(),
    };
  }
}

List<ParkingLot> parkingLotsDemoPage1 = [
  ParkingLot(
    parkingLotID: 'PL001',
    parkingLotName: 'Bãi xe Trung tâm',
    address: '123 Đường Lê Lợi, Quận 1, TP.HCM',
    latitude: 10.7769,
    longitude: 106.7009,
    totalSlot: 100,
    status: LotStatus.ON,
    rate: 5.0,
    description: 'Bãi đỗ xe gần trung tâm thương mại, an ninh 24/7.',
    images: [
      Images(imagesID: 'IMG001', url: 'assets/images/featured _items_1.png'),
      Images(imagesID: 'IMG002', url: 'assets/images/featured _items_1.png'),
    ],
    discounts: [
      Discount(
          discountId: 'D001',
          discountCode: 'SALE10',
          discountType: DiscountType.PERCENTAGE,
          discountValue: 10.0,
          description: 'Giảm 10% cho khách hàng lần đầu tiên.'
      ),
    ],
  ),
  ParkingLot(
    parkingLotID: 'PL002',
    parkingLotName: 'Bãi xe Bệnh viện',
    address: '456 Đường Nguyễn Trãi, Quận 5, TP.HCM',
    latitude: 10.7626,
    longitude: 106.6822,
    totalSlot: 50,
    status: LotStatus.FULL_SLOT,
    rate: 4.0,
    description: 'Bãi đỗ xe dành cho bệnh nhân và nhân viên y tế.',
    images: [
      Images(imagesID: 'IMG003', url: 'assets/images/featured _items_2.png'),
      Images(imagesID: 'IMG004', url: 'assets/images/featured _items_2.png'),
    ],
    discounts: [
      Discount(
          discountId: 'D002',
          discountCode: 'HEALTH20',
          discountType: DiscountType.FIXED,
          discountValue: 2000.0,
          description: 'Giảm 2000đ cho mỗi lượt gửi xe của bệnh nhân.'
      ),
    ],
  ),
  ParkingLot(
    parkingLotID: 'PL003',
    parkingLotName: 'Bãi xe Sân bay',
    address: 'Sân bay Tân Sơn Nhất, Quận Tân Bình, TP.HCM',
    latitude: 10.8188,
    longitude: 106.6518,
    totalSlot: 200,
    status: LotStatus.OFF,
    rate: 10.0,
    description: 'Bãi đỗ xe sân bay, phù hợp cho gửi dài ngày.',
    images: [
      Images(imagesID: 'IMG005', url: 'assets/images/featured _items_2.png'),
      Images(imagesID: 'IMG006', url: 'assets/images/featured _items_2.png'),
    ],
    discounts: [
      Discount(
          discountId: 'D003',
          discountCode: 'AIRPORT5',
          discountType: DiscountType.PERCENTAGE,
          discountValue: 5.0,
          description: 'Giảm 5% cho khách gửi xe dài hạn (trên 7 ngày).'
      ),
    ],
  ),
];
List<ParkingLot> parkingLotsDemoPage2 = [
  ParkingLot(
    parkingLotID: 'PL001',
    parkingLotName: 'Bãi xe Trung tâm',
    address: '123 Đường Lê Lợi, Quận 1, TP.HCM',
    latitude: 10.7769,
    longitude: 106.7009,
    totalSlot: 100,
    status: LotStatus.ON,
    rate: 5.0,
    description: 'Bãi đỗ xe gần trung tâm thương mại, an ninh 24/7.',
    images: [
      Images(imagesID: 'IMG001', url: 'assets/images/featured _items_1.png'),
      Images(imagesID: 'IMG002', url: 'assets/images/featured _items_1.png'),
    ],
    discounts: [
      Discount(
          discountId: 'D001',
          discountCode: 'SALE10',
          discountType: DiscountType.PERCENTAGE,
          discountValue: 10.0,
          description: 'Giảm 10% cho khách hàng lần đầu tiên.'
      ),
    ],
  ),
  ParkingLot(
    parkingLotID: 'PL002',
    parkingLotName: 'Bãi xe Bệnh viện',
    address: '456 Đường Nguyễn Trãi, Quận 5, TP.HCM',
    latitude: 10.7626,
    longitude: 106.6822,
    totalSlot: 50,
    status: LotStatus.FULL_SLOT,
    rate: 4.0,
    description: 'Bãi đỗ xe dành cho bệnh nhân và nhân viên y tế.',
    images: [
      Images(imagesID: 'IMG003', url: 'assets/images/featured _items_2.png'),
      Images(imagesID: 'IMG004', url: 'assets/images/featured _items_2.png'),
    ],
    discounts: [
      Discount(
          discountId: 'D002',
          discountCode: 'HEALTH20',
          discountType: DiscountType.FIXED,
          discountValue: 2000.0,
          description: 'Giảm 2000đ cho mỗi lượt gửi xe của bệnh nhân.'
      ),
    ],
  ),
  ParkingLot(
    parkingLotID: 'PL003',
    parkingLotName: 'Bãi xe Sân bay',
    address: 'Sân bay Tân Sơn Nhất, Quận Tân Bình, TP.HCM',
    latitude: 10.8188,
    longitude: 106.6518,
    totalSlot: 200,
    status: LotStatus.OFF,
    rate: 10.0,
    description: 'Bãi đỗ xe sân bay, phù hợp cho gửi dài ngày.',
    images: [
      Images(imagesID: 'IMG005', url: 'assets/images/featured _items_2.png'),
      Images(imagesID: 'IMG006', url: 'assets/images/featured _items_2.png'),
    ],
    discounts: [
      Discount(
          discountId: 'D003',
          discountCode: 'AIRPORT5',
          discountType: DiscountType.PERCENTAGE,
          discountValue: 5.0,
          description: 'Giảm 5% cho khách gửi xe dài hạn (trên 7 ngày).'
      ),
    ],
  ),
];
List<ParkingLot> parkingLotsDemoPage3 = [
  ParkingLot(
    parkingLotID: 'PL001',
    parkingLotName: 'Bãi xe Trung tâm',
    address: '123 Đường Lê Lợi, Quận 1, TP.HCM',
    latitude: 10.7769,
    longitude: 106.7009,
    totalSlot: 100,
    status: LotStatus.ON,
    rate: 5.0,
    description: 'Bãi đỗ xe gần trung tâm thương mại, an ninh 24/7.',
    images: [
      Images(imagesID: 'IMG001', url: 'assets/images/featured _items_1.png'),
      Images(imagesID: 'IMG002', url: 'assets/images/featured _items_1.png'),
    ],
    discounts: [
      Discount(
          discountId: 'D001',
          discountCode: 'SALE10',
          discountType: DiscountType.PERCENTAGE,
          discountValue: 10.0,
          description: 'Giảm 10% cho khách hàng lần đầu tiên.'
      ),
    ],
  ),
  ParkingLot(
    parkingLotID: 'PL002',
    parkingLotName: 'Bãi xe Bệnh viện',
    address: '456 Đường Nguyễn Trãi, Quận 5, TP.HCM',
    latitude: 10.7626,
    longitude: 106.6822,
    totalSlot: 50,
    status: LotStatus.FULL_SLOT,
    rate: 4.0,
    description: 'Bãi đỗ xe dành cho bệnh nhân và nhân viên y tế.',
    images: [
      Images(imagesID: 'IMG003', url: 'assets/images/featured _items_2.png'),
      Images(imagesID: 'IMG004', url: 'assets/images/featured _items_2.png'),
    ],
    discounts: [
      Discount(
          discountId: 'D002',
          discountCode: 'HEALTH20',
          discountType: DiscountType.FIXED,
          discountValue: 2000.0,
          description: 'Giảm 2000đ cho mỗi lượt gửi xe của bệnh nhân.'
      ),
    ],
  ),
  ParkingLot(
    parkingLotID: 'PL003',
    parkingLotName: 'Bãi xe Sân bay',
    address: 'Sân bay Tân Sơn Nhất, Quận Tân Bình, TP.HCM',
    latitude: 10.8188,
    longitude: 106.6518,
    totalSlot: 200,
    status: LotStatus.OFF,
    rate: 10.0,
    description: 'Bãi đỗ xe sân bay, phù hợp cho gửi dài ngày.',
    images: [
      Images(imagesID: 'IMG005', url: 'assets/images/featured _items_2.png'),
      Images(imagesID: 'IMG006', url: 'assets/images/featured _items_2.png'),
    ],
    discounts: [
      Discount(
          discountId: 'D003',
          discountCode: 'AIRPORT5',
          discountType: DiscountType.PERCENTAGE,
          discountValue: 5.0,
          description: 'Giảm 5% cho khách gửi xe dài hạn (trên 7 ngày).'
      ),
    ],
  ),
];




