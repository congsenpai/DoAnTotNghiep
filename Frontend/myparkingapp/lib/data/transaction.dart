enum Transactions { TOP_UP, PAYMENT }
enum TransactionStatus { COMPLETED, PENDING, FAILED }

class Transaction {
  String transactionId;
  double amount;
  String description;
  Transactions type;
  TransactionStatus status;
  String walletId;

  Transaction({
    required this.transactionId,
    required this.amount,
    required this.description,
    required this.type,
    required this.status,
    required this.walletId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionId: json['transactionId'],
      amount: (json['amount'] as num).toDouble(),
      description: json['description'],
      type: Transactions.values.firstWhere(
              (e) => e.toString().split('.').last == json['type']),
      status: TransactionStatus.values.firstWhere(
              (e) => e.toString().split('.').last == json['status']),
      walletId: json['walletId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'amount': amount,
      'description': description,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'walletId': walletId,
    };
  }

  @override
  String toString() {
    return 'Transaction(transactionId: $transactionId, amount: $amount, description: $description, type: $type, status: $status, walletId: $walletId)';
  }
}
List<Transaction> transactions = [
  Transaction(
    transactionId: "W001",
    amount: 150.0,
    description: "Top up wallet",
    type: Transactions.TOP_UP,
    status: TransactionStatus.COMPLETED,
    walletId: "W001",
  ),
  Transaction(
    transactionId: "W002",
    amount: 200.0,
    description: "Payment for order #1234",
    type: Transactions.PAYMENT,
    status: TransactionStatus.PENDING,
    walletId: "W001",
  ),
  Transaction(
    transactionId: "W003",
    amount: 50.0,
    description: "Top up bonus",
    type: Transactions.TOP_UP,
    status: TransactionStatus.FAILED,
    walletId: "W001",
  ),
  Transaction(
    transactionId: "W004",
    amount: 75.5,
    description: "Payment for order #5678",
    type: Transactions.PAYMENT,
    status: TransactionStatus.COMPLETED,
    walletId: "W001",
  ),
  Transaction(
    transactionId: "W005",
    amount: 300.0,
    description: "Top up via credit card",
    type: Transactions.TOP_UP,
    status: TransactionStatus.PENDING,
    walletId: "W001",
  ),
  Transaction(
    transactionId: "W006",
    amount: 120.0,
    description: "Payment for subscription",
    type: Transactions.PAYMENT,
    status: TransactionStatus.COMPLETED,
    walletId: "W001",
  ),
  Transaction(
    transactionId: "W007",
    amount: 500.0,
    description: "Top up special event",
    type: Transactions.TOP_UP,
    status: TransactionStatus.COMPLETED,
    walletId: "W001",
  ),
  Transaction(
    transactionId: "W008",
    amount: 80.0,
    description: "Payment for online course",
    type: Transactions.PAYMENT,
    status: TransactionStatus.FAILED,
    walletId: "W001",
  ),
];