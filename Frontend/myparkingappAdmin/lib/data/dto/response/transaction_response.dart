// ignore_for_file: constant_identifier_names

enum TransactionType { TOP_UP, PAYMENT }
enum TransactionStatus { COMPLETED, PENDING, FAILED }

class TransactionResponse {
  final String icon;
  final String bankName;
  final double amount;
  final String typeMoney;
  final TransactionType type;
  final DateTime date;
  final String transactionId;
  final String walletId;
  final String description;
  final TransactionStatus status; // ✅ Thêm trường status

  TransactionResponse({
    required this.walletId,
    required this.transactionId,
    required this.icon,
    required this.bankName,
    required this.date,
    required this.amount,
    required this.type,
    required this.typeMoney,
    required this.description,
    required this.status, // ✅ Thêm vào constructor
  });

  /// **Chuyển từ JSON sang `TransactionResponse` object**
  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      walletId: json["walletId"] ?? '',
      transactionId: json["transactionId"] ?? '',
      icon: json["icon"] ?? '',
      bankName: json["bankName"] ?? '',
      date: DateTime.tryParse(json["date"] ?? '') ?? DateTime.now(),
      amount: (json["amount"] ?? 0.0).toDouble(),
      type: _parseTransactionType(json["type"]),
      typeMoney: json["typeMoney"] ?? '',
      description: json["description"] ?? '',
      status: _parseTransactionStatus(json["status"]), // ✅ Thêm status
    );
  }

  /// **Chuyển từ `TransactionResponse` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "walletId": walletId,
      "transactionId": transactionId,
      "icon": icon,
      "bankName": bankName,
      "date": date.toIso8601String(),
      "amount": amount,
      "type": type.name, // ✅ Chuyển enum thành string
      "typeMoney": typeMoney,
      "description": description,
      "status": status.name, // ✅ Thêm status
    };
  }

  @override
  String toString() {
    return "Transaction(transactionId: $transactionId, amount: $amount, type: $type, status: $status)";
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
