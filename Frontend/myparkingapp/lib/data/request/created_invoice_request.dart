import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/response/discount_response.dart';
import 'package:myparkingapp/data/response/vehicle__response.dart';

enum InvoiceStatus { PENDING, PAID, CANCELLED }

class CreatedInvoiceRequest {
  String invoiceID;
  double totalAmount;
  InvoiceStatus status;
  String description;
  List<CreatedTransactionRequest> transaction;
  DiscountResponse discount;
  String parkingSlotName;
  String parkingLotName;
  VehicleResponse vehicle;
  String userID;
  bool isMonthlyTicket;

  CreatedInvoiceRequest({
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

  Map<String, dynamic> toJson() {
  return {
    'invoiceID': invoiceID,
    'totalAmount': totalAmount,
    'status': status.toString().split('.').last, // Chuyển enum thành String
    'description': description,
    'transaction': transaction.map((t) => t.toJson()).toList(),
    'discount': discount.toJson(),
    'parkingSlotName': parkingSlotName,
    'parkingLotName': parkingLotName,
    'vehicle': vehicle.toJson(),
    'userID': userID,
    'isMonthlyTicket': isMonthlyTicket,
  };
}



  @override
  String toString() {
    return 'Invoice(invoiceId: $invoiceID, status: $status, description: $description, transaction: $transaction, discount: $discount, parkingSlotName: $parkingSlotName, vehicle: $vehicle, userId: $userID)';
  }
}