import 'package:myparkingapp/data/response/wallet_response.dart';

abstract class WalletState {}

class WalletInitialState extends WalletState{}

class WalletLoadingState extends WalletState{}

class WalletLoadedState extends WalletState{
  List<WalletResponse> wallets;
  WalletLoadedState(this.wallets);
}

class WalletSuccessState extends WalletState{
  String mess;
  WalletSuccessState(this.mess);

}

class WalletErrorState extends WalletState{
  String mess;
  WalletErrorState(this.mess);
}