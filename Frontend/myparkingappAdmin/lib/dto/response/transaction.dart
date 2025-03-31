// ignore_for_file: constant_identifier_names

enum TransactionType { TOP_UP, PAYMENT }

class Transaction {
  final String icon;
  final String bankName;
  final double amount;
  final String typeMoney;
  final TransactionType type;
  final DateTime date;
  final String transactionId;
  final String walletId;
  final String description;

  Transaction({
    required this.walletId,
    required this.transactionId,
    required this.icon,
    required this.bankName,
    required this.date,
    required this.amount,
    required this.type,
    required this.typeMoney,
    required this.description,
  });

  /// **Chuyển từ JSON sang `Transaction` object**
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      walletId: json["walletId"] ?? '',
      transactionId: json["transactionId"] ?? '',
      icon: json["icon"] ?? '',
      bankName: json["bankName"] ?? '',
      date: DateTime.parse(json["date"] ?? DateTime.now().toIso8601String()),
      amount: (json["amount"] ?? 0).toDouble(),
      type: json["type"] == "TOP_UP" ? TransactionType.TOP_UP : TransactionType.PAYMENT,
      typeMoney: json["typeMoney"] ?? '',
      description: json["description"] ?? '',
    );
  }

  /// **Chuyển từ `Transaction` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "walletId": walletId,
      "transactionId": transactionId,
      "icon": icon,
      "bankName": bankName,
      "date": date.toIso8601String(),
      "amount": amount,
      "type": type == TransactionType.TOP_UP ? "TOP_UP" : "PAYMENT",
      "typeMoney": typeMoney,
      "description": description,
    };
  }

  @override
  String toString() {
    return "Transaction(transactionId: $transactionId, amount: $amount, type: $type)";
  }
}
List<Transaction> demoTransactionList = [
  Transaction(
    icon: "assets/logos/zybank-rect.svg",
    bankName: "ZY Bank",
    date: DateTime.now(),
    amount: 100000.0,
    typeMoney: "VNĐ",
    type: TransactionType.TOP_UP, // Nạp tiền
    transactionId: '1',
    walletId: '2',
    description: 'Deposit into wallet',
  ),
  Transaction(
    icon: "assets/logos/zybank-rect.svg",
    bankName: "ZY Bank",
    date: DateTime.now(),
    amount: 200000.0,
    typeMoney: "VNĐ",
    type: TransactionType.PAYMENT, // Thanh toán
    transactionId: '2',
    walletId: '2',
    description: 'Payment for parking fee',
  ),
];