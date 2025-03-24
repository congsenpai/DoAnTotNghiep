

import 'package:myparkingapp/data/response/transaction__response.dart';

class CreatedTransactionRequest {
  String transactionID;
  double currentBalance;
  String description;
  Transactions type;
  TransactionStatus status;
  String walletId;

  CreatedTransactionRequest({
    required this.transactionID,
    required this.currentBalance,
    required this.description,
    required this.type,
    required this.status,
    required this.walletId,
  });

  Map<String, dynamic> toJson() {
  return {
    'transactionId': transactionID,
    'currentBalance': currentBalance,
    'description': description,
    'type': type.toString().split('.').last, // Chuyển enum thành String
    'status': status.toString().split('.').last, // Chuyển enum thành String
    'walletId': walletId,
  };
}


  @override
  String toString() {
    return 'Transaction(transactionId: $transactionID, amount: $currentBalance, description: $description, type: $type, status: $status, walletId: $walletId)';
  }
}