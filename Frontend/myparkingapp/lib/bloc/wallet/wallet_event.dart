
import 'package:myparkingapp/data/response/user__response.dart';
import 'package:myparkingapp/data/response/wallet__response.dart';

abstract class WalletEvent {}

class WalletInitialEvent extends WalletEvent{
  final UserResponse user;
  final List<WalletResponse> wallets; 
  WalletInitialEvent(this.user,this.wallets);
}

class AddWalletEvent extends WalletEvent{
  double balance;
  String currency;
  String name;
  String userId;
  AddWalletEvent(this.balance,this.currency,this.name,this.userId);

}
class LockWalletEvent extends WalletEvent{
  String walletId;
  LockWalletEvent(this.walletId);
}

