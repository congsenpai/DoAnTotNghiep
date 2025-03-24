import 'package:myparkingapp/data/response/transaction.dart';
import 'package:myparkingapp/data/response/vehicle.dart';
import 'discount.dart';

class InvoiceOnPage {
  List<Invoice> invoices;
  int page;
  int pageAmount;

  InvoiceOnPage(this.invoices, this.page, this.pageAmount);
}

List<InvoiceOnPage> invoiceOnPages = [
  InvoiceOnPage(invoicesPage1, 1, 2),
  InvoiceOnPage(invoicesPage2, 2, 2)
];

enum InvoiceStatus { PENDING, PAID, CANCELLED }

class Invoice {
  String invoiceID;
  double totalAmount;
  InvoiceStatus status;
  String description;
  List<Transaction> transaction;
  Discount discount;
  String parkingSlotName;
  String parkingLotName;
  Vehicle vehicle;
  String userID;
  bool isMonthlyTicket;

  Invoice({
    required this.invoiceID,
    required this.totalAmount,
    required this.status,
    required this.description,
    required this.transaction,
    required this.discount,
    required this.parkingSlotName,
    required this.vehicle,
    required this.userID,
    required this.parkingLotName,
    required this.isMonthlyTicket,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      invoiceID: json['invoiceId'] ?? '',
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      status: InvoiceStatus.values.firstWhere(
          (e) => e.toString().split('.').last == json['status'],
          orElse: () => InvoiceStatus.PENDING),
      description: json['description'] ?? '',
      transaction: (json['transaction'] as List<dynamic>?)
              ?.map((t) => Transaction.fromJson(t))
              .toList() ??
          [],
      discount: Discount.fromJson(json['discount'] ?? {}),
      vehicle: Vehicle.fromJson(json['vehicle'] ?? {}),
      userID: json['userId'] ?? '',
      parkingSlotName: json['parkingSlotName'] ?? '',
      parkingLotName: json['parkingLotName'] ?? '',
      isMonthlyTicket: json['isMonthlyTicket'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Invoice(invoiceId: $invoiceID, status: $status, description: $description, transaction: $transaction, discount: $discount, parkingSlotName: $parkingSlotName, vehicle: $vehicle, userId: $userID)';
  }
}

Discount discountSample = Discount(
  discountId: 'D001',
  discountCode: 'SALE10',
  discountType: DiscountType.PERCENTAGE,
  discountValue: 10.0,
  description: 'Giảm 10% cho khách hàng lần đầu tiên.',
  parkingLotId: '',
  expiredAt: '',
);

Vehicle vehicleSample = Vehicle(
  vehicleId: "V001",
  vehicleType: VehicleType.CAR,
  licensePlate: "ABC-1234",
  description: "Red Sedan Car",
);

final List<Invoice> invoicesPage1 = [
  Invoice(
    invoiceID: "INV001",
    status: InvoiceStatus.PAID,
    description: "Invoice for Top up wallet",
    transaction: [transactions[0]],
    discount: discountSample,
    vehicle: vehicleSample,
    userID: "U001",
    totalAmount: 100.0,
    parkingSlotName: 'Slot A1',
    parkingLotName: 'Lot 1',
    isMonthlyTicket: false,
  ),
  Invoice(
    invoiceID: "INV002",
    status: InvoiceStatus.PENDING,
    description: "Invoice for Payment for order #1234",
    transaction: [transactions[1]],
    discount: discountSample,
    vehicle: vehicleSample,
    userID: "U001",
    totalAmount: 150.0,
    parkingSlotName: 'Slot B2',
    parkingLotName: 'Lot 2',
    isMonthlyTicket: false,
  ),
];

final List<Invoice> invoicesPage2 = [
  Invoice(
    invoiceID: "INV003",
    status: InvoiceStatus.CANCELLED,
    description: "Invoice for Top up bonus",
    transaction: [transactions[2]],
    discount: discountSample,
    vehicle: vehicleSample,
    userID: "U001",
    totalAmount: 200.0,
    parkingSlotName: 'Slot C3',
    parkingLotName: 'Lot 3',
    isMonthlyTicket: true,
  ),
  Invoice(
    invoiceID: "INV004",
    status: InvoiceStatus.PAID,
    description: "Invoice for Payment for order #5678",
    transaction: [transactions[3]],
    discount: discountSample,
    vehicle: vehicleSample,
    userID: "U001",
    totalAmount: 180.0,
    parkingSlotName: 'Slot D4',
    parkingLotName: 'Lot 4',
    isMonthlyTicket: false,
  ),
];
