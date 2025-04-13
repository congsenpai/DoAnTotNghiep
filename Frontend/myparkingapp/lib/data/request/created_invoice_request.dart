// ignore_for_file: constant_identifier_names

import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/response/discount_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';

class InvoiceCreatedDailyRequest {
  double total;
  String description;
  String discountCode;
  String parkingSlotID;
  String vehicleID;
  String userID;
  String walletID;


  InvoiceCreatedDailyRequest(this.description, this.discountCode, this.parkingSlotID,
this.vehicleID, this.userID, this.walletID,this.total);

  Map<String, dynamic> toJson() {
  return {
    'description': description,
    'discountCode': discountCode,
    'parkingSlotID': parkingSlotID,
    'vehicleID': vehicleID,
    'userID': userID,
    'walletID':walletID
  };
}

  @override
  String toString() {
    return 'CreatedInvoiceRequest{description: $description, discountCode: $discountCode, parkingSlotID: $parkingSlotID, vehicleID: $vehicleID, userID: $userID, walletID: $walletID}';
  }
}

class PaymentDailyRequest {
  String invoiceID;
  String discountID;
  String parkingSlotID;
  String walletID;
  double total;


  PaymentDailyRequest(this.invoiceID, this.discountID, this.parkingSlotID,
      this.walletID,this.total);

  Map<String, dynamic> toJson() {
    return {
      'parkingSlotID': parkingSlotID,
      'walletID':walletID,
      'invoiceID':invoiceID,
      'discountID':discountID
    };
  }

  @override
  String toString() {
    return 'PaymentDailyRequest{invoiceID: $invoiceID, discountID: $discountID, parkingSlotID: $parkingSlotID, walletID: $walletID}';
  }


}

class InvoiceCreatedMonthlyRequest {
  String description;
  String discountCode;
  String parkingSlotID;
  String vehicleID;
  String userID;
  String walletID;
  DateTime startedAt;
  DateTime expiredAt;
  double total;


  InvoiceCreatedMonthlyRequest(this.description, this.discountCode,
      this.parkingSlotID, this.vehicleID, this.userID, this.walletID,
      this.startedAt, this.expiredAt,this.total);

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'discountCode': discountCode,
      'parkingSlotID': parkingSlotID,
      'vehicleID': vehicleID,
      'userID': userID,
      'walletID': walletID,
      'startedAt': startedAt.toIso8601String(),
      'expiredAt': expiredAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'InvoiceCreatedMonthlyRequest{description: $description, discountCode: $discountCode, parkingSlotID: $parkingSlotID, vehicleID: $vehicleID, userID: $userID, walletID: $walletID, startedAt: $startedAt, expiredAt: $expiredAt}';
  }
}