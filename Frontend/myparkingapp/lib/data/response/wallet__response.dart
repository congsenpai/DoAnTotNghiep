class WalletResponse {
  String walletId;
  double balance;
  String currency;
  String name;
  String userId;

  WalletResponse({
    required this.walletId,
    required this.balance,
    required this.currency,
    required this.name,
    required this.userId,
  });

  // Convert JSON to Wallet object
  factory WalletResponse.fromJson(Map<String, dynamic> json) {
    return WalletResponse(
      walletId: json['walletId'] as String,
      balance: (json['balance'] as num).toDouble(),
      currency: json['currency'] as String,
      name: json['name'] as String,
      userId: json['userId'] as String,
    );
  }

  // Convert Wallet object to JSON
  Map<String, dynamic> toJson() {
    return {
      'walletId': walletId,
      'balance': balance,
      'currency': currency,
      'name': name,
      'userId':userId
    };
  }
}