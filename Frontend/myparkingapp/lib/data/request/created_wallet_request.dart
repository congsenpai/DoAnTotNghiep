class CreatedWalletRequest {
  double balance;
  String currency;
  String name;
  String userId;

  CreatedWalletRequest({
    required this.balance,
    required this.currency,
    required this.name,
    required this.userId,
  });
  // Convert Wallet object to JSON
  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'currency': currency,
      'name': name,
      'userId':userId
    };
  }
}