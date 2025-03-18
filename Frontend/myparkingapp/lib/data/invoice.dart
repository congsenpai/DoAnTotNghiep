import 'package:myparkingapp/data/parking_slots.dart';
import 'package:myparkingapp/data/transaction.dart';
import 'package:myparkingapp/data/user.dart';
import 'package:myparkingapp/data/vehicle.dart';
import 'discount.dart';

enum InvoiceStatus { PENDING, PAID, CANCELLED }

class Invoice {
  String invoiceId;
  InvoiceStatus status;
  String description;
  Transaction transaction;
  Discount discount;
  String slotId;
  String parkingLotId;
  Vehicle vehicle;
  String userId;

  Invoice({
    required this.invoiceId,
    required this.status,
    required this.description,
    required this.transaction,
    required this.discount,
    required this.slotId,
    required this.vehicle,
    required this.userId,
    required this.parkingLotId,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      invoiceId: json['invoiceId'],
      status: InvoiceStatus.values.firstWhere(
              (e) => e.toString().split('.').last == json['status']),
      description: json['description'],
      transaction: Transaction.fromJson(json['transaction']),
      discount: Discount.fromJson(json['discount']),
      slotId: json['slotId'],
      vehicle: Vehicle.fromJson(json['vehicle']),
      userId: json['userId'], parkingLotId: 'PL001',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invoiceId': invoiceId,
      'status': status.toString().split('.').last,
      'description': description,
      'transaction': transaction.toJson(),
      'discount': discount.toJson(),
      'slotId': slotId,
      'vehicle': vehicle.toJson(),
      'userId': userId,
    };
  }

  @override
  String toString() {
    return 'Invoice(invoiceId: $invoiceId, status: $status, description: $description, transaction: $transaction, discount: $discount, slotId: $slotId, vehicle: $vehicle, userId: $userId)';
  }
}

Discount discountSample = Discount(
    discountId: 'D001',
    discountCode: 'SALE10',
    discountType: DiscountType.PERCENTAGE,
    discountValue: 10.0,
    description: 'Giảm 10% cho khách hàng lần đầu tiên.', parkingLotId: ''
);


Vehicle vehicleSample = Vehicle(
vehicleId: "V001",
vehicleType: VehicleType.CAR,
licensePlate: "ABC-1234",
description: "Red Sedan Car",
);
    
final List<Invoice> invoices = [
  Invoice(
    invoiceId: "INV001",
    status: InvoiceStatus.PAID,
    description: "Invoice for Top up wallet",
    transaction: transactions[0],
    discount: discountSample,
    slotId: "S011",
    vehicle: vehicleSample,
    userId: "U001", parkingLotId: 'PL001',
  ),
  Invoice(
    invoiceId: "INV002",
    status: InvoiceStatus.PENDING,
    description: "Invoice for Payment for order #1234",
    transaction: transactions[1],
    discount: discountSample,
    slotId: "S002",
    vehicle: vehicleSample,
    userId: "U001", parkingLotId: 'PL001',
  ),
  Invoice(
    invoiceId: "INV003",
    status: InvoiceStatus.CANCELLED,
    description: "Invoice for Top up bonus",
    transaction: transactions[2],
    discount: discountSample,
    slotId: "S003",
    vehicle: vehicleSample,
    userId: "U001", parkingLotId: 'PL001',
  ),
  Invoice(
    invoiceId: "INV004",
    status: InvoiceStatus.PAID,
    description: "Invoice for Payment for order #5678",
    transaction: transactions[3],
    discount: discountSample,
    slotId: "S004",
    vehicle: vehicleSample,
    userId: "U001", parkingLotId: 'PL001',
  ),
  Invoice(
    invoiceId: "INV005",
    status: InvoiceStatus.PENDING,
    description: "Invoice for Top up via credit card",
    transaction: transactions[4],
    discount: discountSample,
    slotId: "S005",
    vehicle: vehicleSample,
    userId: "U001", parkingLotId: 'PL001',
  ),
  Invoice(
    invoiceId: "INV006",
    status: InvoiceStatus.PAID,
    description: "Invoice for Payment for subscription",
    transaction: transactions[5],
    discount: discountSample,
    slotId: "S006",
    vehicle: vehicleSample,
    userId: "U001", parkingLotId: 'PL001',
  ),
  Invoice(
    invoiceId: "INV007",
    status: InvoiceStatus.PAID,
    description: "Invoice for Top up special event",
    transaction: transactions[6],
    discount: discountSample,
    slotId: "S007",
    vehicle: vehicleSample,
    userId: "U001", parkingLotId: 'PL001',
  ),
  Invoice(
    invoiceId: "INV008",
    status: InvoiceStatus.CANCELLED,
    description: "Invoice for Payment for online course",
    transaction: transactions[7],
    discount: discountSample,
    slotId: "S008",
    vehicle: vehicleSample,
    userId: "U001", parkingLotId: 'PL001',
  ),
];