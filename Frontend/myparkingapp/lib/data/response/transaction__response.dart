class TransactionOnPage{
  List<TransactionResponse> trans;
  int page;
  int pageAmount;
  TransactionOnPage(this.trans,this.page,this.pageAmount);
}


enum Transactions { TOP_UP, PAYMENT }
enum TransactionStatus { COMPLETED, PENDING, FAILED }

class TransactionResponse {
  String transactionID;
  double currentBalance;
  String description;
  Transactions type;
  TransactionStatus status;
  String walletId;

  TransactionResponse({
    required this.transactionID,
    required this.currentBalance,
    required this.description,
    required this.type,
    required this.status,
    required this.walletId,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      transactionID: json['transactionId'],
      currentBalance: (json['currentBalance'] as num).toDouble(),
      description: json['description'],
      type: Transactions.values.firstWhere(
              (e) => e.toString().split('.').last == json['type']),
      status: TransactionStatus.values.firstWhere(
              (e) => e.toString().split('.').last == json['status']),
      walletId: json['walletId'],
    );
  }

  @override
  String toString() {
    return 'Transaction(transactionId: $transactionID, amount: $currentBalance, description: $description, type: $type, status: $status, walletId: $walletId)';
  }
}
List<TransactionResponse> transactions = [
  TransactionResponse(
    transactionID: "W001",
    currentBalance: 150.0,
    description: "Top up wallet",
    type: Transactions.TOP_UP,
    status: TransactionStatus.COMPLETED,
    walletId: "W001",
  ),
  TransactionResponse(
    transactionID: "W002",
    currentBalance: 200.0,
    description: "Payment for order #1234",
    type: Transactions.PAYMENT,
    status: TransactionStatus.PENDING,
    walletId: "W001",
  ),
  TransactionResponse(
    transactionID: "W003",
    currentBalance: 50.0,
    description: "Top up bonus",
    type: Transactions.TOP_UP,
    status: TransactionStatus.FAILED,
    walletId: "W001",
  ),
  TransactionResponse(
    transactionID: "W004",
    currentBalance: 75.5,
    description: "Payment for order #5678",
    type: Transactions.PAYMENT,
    status: TransactionStatus.COMPLETED,
    walletId: "W001",
  ),
  TransactionResponse(
    transactionID: "W005",
    currentBalance: 300.0,
    description: "Top up via credit card",
    type: Transactions.TOP_UP,
    status: TransactionStatus.PENDING,
    walletId: "W001",
  ),
  TransactionResponse(
    transactionID: "W006",
    currentBalance: 120.0,
    description: "Payment for subscription",
    type: Transactions.PAYMENT,
    status: TransactionStatus.COMPLETED,
    walletId: "W001",
  ),
  TransactionResponse(
    transactionID: "W007",
    currentBalance: 500.0,
    description: "Top up special event",
    type: Transactions.TOP_UP,
    status: TransactionStatus.COMPLETED,
    walletId: "W001",
  ),
  TransactionResponse(
    transactionID: "W008",
    currentBalance: 80.0,
    description: "Payment for online course",
    type: Transactions.PAYMENT,
    status: TransactionStatus.FAILED,
    walletId: "W001",
  ),
];