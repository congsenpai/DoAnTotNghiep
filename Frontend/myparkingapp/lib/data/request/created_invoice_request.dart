// ignore_for_file: constant_identifier_names

import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/response/discount_response.dart';
import 'package:myparkingapp/data/response/vehicle__response.dart';

class CreatedInvoiceRequest {
  double totalAmount;
  String description;
  List<CreatedTransactionRequest> transaction;
  DiscountResponse discount;
  String parkingSlotName;
  String parkingLotName;
  VehicleResponse vehicle;
  String userID;
  bool isMonthlyTicket;

  CreatedInvoiceRequest({
    required this.totalAmount,
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
    'totalAmount': totalAmount,
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
    return 'Invoice(description: $description, transaction: $transaction, discount: $discount, parkingSlotName: $parkingSlotName, vehicle: $vehicle, userId: $userID)';
  }
}