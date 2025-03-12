class Wallet {
  String walletId;
  double balance;
  String currency;
  String name;

  Wallet({
    required this.walletId,
    required this.balance,
    required this.currency,
    required this.name,
  });

  // Convert JSON to Wallet object
  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      walletId: json['walletId'] as String,
      balance: (json['balance'] as num).toDouble(),
      currency: json['currency'] as String,
      name: json['name'] as String,
    );
  }

  // Convert Wallet object to JSON
  Map<String, dynamic> toJson() {
    return {
      'walletId': walletId,
      'balance': balance,
      'currency': currency,
      'name': name,
    };
  }

}