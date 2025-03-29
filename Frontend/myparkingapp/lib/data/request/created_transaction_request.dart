

import 'package:myparkingapp/data/response/transaction__response.dart';

class CreatedTransactionRequest {
  double currentBalance;
  String description;
  Transactions type;
  String walletId;

  CreatedTransactionRequest({
    required this.currentBalance,
    required this.description,
    required this.type,
    required this.walletId,
  });

  Map<String, dynamic> toJson() {
  return {
    'currentBalance': currentBalance,
    'description': description,
    'type': type.toString().split('.').last, // Chuyển enum thành String
    'walletId': walletId,
  };
}


  @override
  String toString() {
    return 'Transaction(amount: $currentBalance, description: $description, type: $type,walletId: $walletId)';
  }
}