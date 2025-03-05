// ignore_for_file: constant_identifier_names

enum Transactions { TOP_UP, PAYMENT }
enum TransactionStatus {
  COMPLETED, PENDING, FAILED
}

class Transaction {
  final String icon;
  final String bankName;
  final double amount;
  final String typeMoney;
  final Transactions type;
  final DateTime date;
  final String transactionId;
  final String walletId;
  final String description;
  final TransactionStatus status;

  Transaction( {
    required this.status,
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
      status:TransactionStatus.values.firstWhere(
              (e) => e.toString().split('.').last == json['status'],
          orElse: () => TransactionStatus.PENDING),
      walletId: json["walletId"] ?? '',
      transactionId: json["transactionId"] ?? '',
      icon: json["icon"] ?? '',
      bankName: json["bankName"] ?? '',
      date: DateTime.parse(json["createdDate"] ?? DateTime.now().toIso8601String()),
      amount: (json["amount"] ?? 0).toDouble(),
      type: Transactions.values.firstWhere(
              (e) => e.toString().split('.').last == json['type'],
          orElse: () => Transactions.PAYMENT),
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
      "type": type.toString().split('.').last,
      "typeMoney": typeMoney,
      "description": description,
      "status": status.toString().split('.').last,
    };
  }

  @override
  String toString() {
    return "Transaction(transactionId: $transactionId, amount: $amount, type: $type, status: $status)";
  }
}

List<Transaction> demoTransactionList = [
  Transaction(
    status:  TransactionStatus.COMPLETED,
    icon: "assets/logos/zybank-rect.svg",
    bankName: "ZY Bank",
    date: DateTime.now(),
    amount: 100000.0,
    typeMoney: "VNĐ",
    type: Transactions.TOP_UP, // Nạp tiền
    transactionId: '1',
    walletId: '2',
    description: 'Deposit into wallet',
  ),
  Transaction(
    status: TransactionStatus.PENDING,
    icon: "assets/logos/zybank-rect.svg",
    bankName: "ZY Bank",
    date: DateTime.now(),
    amount: 200000.0,
    typeMoney: "VNĐ",
    type: Transactions.PAYMENT, // Thanh toán
    transactionId: '2',
    walletId: '2',
    description: 'Payment for parking fee',
  ),
];
