// ignore_for_file: constant_identifier_names

enum TransactionType { TOP_UP, PAYMENT,DEPOSIT,RETURN_DEPOSIT }
enum TransactionStatus { COMPLETED, PENDING, FAILED }

class TransactionResponse {
  String transactionId;
  double currentBalance;
  String description;
  TransactionType type;
  TransactionStatus status;
  String walletId;
  DateTime createAt;

  TransactionResponse({
    required this.transactionId,
    required this.currentBalance,
    required this.description,
    required this.type,
    required this.status,
    required this.walletId,
    required this.createAt,
  });

  /// **Chuyển từ JSON sang `TransactionResponse` object**
  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      transactionId: json["transactionId"] ?? '',
      currentBalance: (json["currentBalance"] ?? 0.0).toDouble(),
      description: json["description"] ?? '',
      type: _parseTransactionType(json["type"]),
      status: _parseTransactionStatus(json["status"]), // Fixed status mapping
      walletId: json["walletId"] ?? '',
      createAt: DateTime.tryParse(json["createAt"] ?? '') ?? DateTime.now(), // Corrected field name
    );
  }

  /// **Chuyển từ `TransactionResponse` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "transactionId": transactionId,
      "currentBalance": currentBalance,
      "description": description,
      "type": type.name, // ✅ Chuyển enum thành string
      "status": status.name, // ✅ Thêm status
      "walletId": walletId,
      "createAt": createAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return "Transaction(transactionId: $transactionId, amount: $currentBalance, type: $type, status: $status)";
  }

  /// **Chuyển `String` thành `TransactionType`**
  static TransactionType _parseTransactionType(String? type) {
    switch (type?.toUpperCase()) {
      case "TOP_UP":
        return TransactionType.TOP_UP;
      case "PAYMENT":
        return TransactionType.PAYMENT;
      default:
        return TransactionType.PAYMENT; // Mặc định nếu dữ liệu sai
    }
  }

  /// **Chuyển `String` thành `TransactionStatus`**
  static TransactionStatus _parseTransactionStatus(String? status) {
    switch (status?.toUpperCase()) {
      case "COMPLETED":
        return TransactionStatus.COMPLETED;
      case "PENDING":
        return TransactionStatus.PENDING;
      case "FAILED":
        return TransactionStatus.FAILED;
      default:
        return TransactionStatus.PENDING; // Mặc định nếu dữ liệu sai
    }
  }
}
