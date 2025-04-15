// ignore_for_file: constant_identifier_names

import 'package:myparkingapp/data/response/transaction_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';
import 'discount_response.dart';

class InvoiceOnPage {
  List<InvoiceResponse> invoices;
  int page;
  int pageTotal;

  InvoiceOnPage(this.invoices, this.page, this.pageTotal);
}


enum InvoiceStatus { PENDING, PAID, CANCELLED }

class InvoiceResponse {
  String invoiceID;
  double totalAmount;
  InvoiceStatus status;
  String description;
  DiscountResponse? discount;
  String parkingSlotName;
  String parkingSlotID;
  String parkingLotName;
  VehicleResponse vehicle;
  String userID;
  bool isMonthlyTicket;
  String objectDecrypt;
  DateTime createdAt;

  InvoiceResponse({
    required this.invoiceID,
    required this.totalAmount,
    required this.status,
    required this.description,
    this.discount,
    required this.parkingSlotName,
    required this.vehicle,
    required this.userID,
    required this.parkingLotName,
    required this.isMonthlyTicket,
    required this.objectDecrypt,
    required this.createdAt,
    required this.parkingSlotID
  });

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) {
    return InvoiceResponse(
      invoiceID: json['invoiceID'] ?? '',
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      status: InvoiceStatus.values.firstWhere(
          (e) => e.toString().split('.').last == json['status'],
          orElse: () => InvoiceStatus.PENDING),
      description: json['description'] ?? '',
      discount: DiscountResponse.fromJson(json['discount'] ?? {}),
      vehicle: VehicleResponse.fromJson(json['vehicle'] ?? {}),
      userID: json['userID'] ?? '',
      parkingSlotName: json['parkingSlotName'] ?? '',
      parkingLotName: json['parkingLotName'] ?? '',
      isMonthlyTicket: json['isMonthlyTicket'] ?? false,
      objectDecrypt:json['objectDecrypt'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      parkingSlotID: json['parkingSlotID']
    );
  }

  @override
  String toString() {
    return 'InvoiceResponse{invoiceID: $invoiceID, totalAmount: $totalAmount, status: $status, description: $description, discount: $discount, parkingSlotName: $parkingSlotName, parkingSlotID: $parkingSlotID, parkingLotName: $parkingLotName, vehicle: $vehicle, userID: $userID, isMonthlyTicket: $isMonthlyTicket, objectDecrypt: $objectDecrypt, createdAt: $createdAt}';
  }


}

DiscountResponse discountSample = DiscountResponse(
  discountId: 'D001',
  discountCode: 'SALE10',
  discountType: DiscountType.PERCENTAGE,
  discountValue: 10.0,
  description: 'Giảm 10% cho khách hàng lần đầu tiên.',
  parkingLotId: '',
  expiredAt: '',
);

VehicleResponse vehicleSample = VehicleResponse(
  vehicleId: "V001",
  vehicleType: VehicleType.CAR,
  licensePlate: "ABC-1234",
  description: "Red Sedan Car",
);


