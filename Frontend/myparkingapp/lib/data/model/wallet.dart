
// ignore_for_file: non_constant_identifier_names

class Wallet {
  final String walletId;
  final String userId;
  final String svgSrc;
  final String name;
  final double balance;
  final bool status;
  final String currency;
  Wallet({
    required this.walletId,
    required this.userId,
    required this.svgSrc,
    required this.name,
    required this.balance,
    required this.status,
    required this.currency,

  });

  /// **Chuyển từ JSON sang `Wallet` object**
  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      walletId: json["walletId"] ?? '',
      userId: json["userId"] ?? '',
      svgSrc: json["svgSrc"] ?? '',
      name: json["name"] ?? '',
      balance: (json["balance"] ?? 0).toDouble(),
      status: json["status"] ?? false,
      currency: json["currency"] ?? '',
    );
  }

  /// **Chuyển từ `Wallet` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "walletId": walletId,
      "userId": userId,
      "svgSrc": svgSrc,
      "name": name,
      "balance": balance,
      "status": status,
      "currency": currency,
    };
  }

  @override
  String toString() {
    return "Wallet(name: $name, balance: $balance, currency: $currency, status: $status)";
  }
}
final List<Wallet> WalletLists = [
  Wallet(
    walletId: "1",
    userId: "U003",
    svgSrc: "assets/icons/wallet.svg",
    name: "Main Wallet",
    balance: 1500.75,
    status: true,
    currency: "USD",
  ),
  Wallet(
    walletId: "2",
    userId: "U003",
    svgSrc: "assets/icons/wallet.svg",
    name: "Savings Wallet",
    balance: 5000.00,
    status: true,
    currency: "USD",
  ),
  Wallet(
    walletId: "3",
    userId: "U003",
    svgSrc: "assets/icons/wallet.svg",
    name: "Crypto Wallet",
    balance: 0.256,
    status: false,
    currency: "BTC",
  ),
];
