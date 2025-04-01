abstract class  WalletState{}

class  WalletInitial extends WalletState{

}

class  WalletLoadingState extends WalletState{

}

class  WalletLoadedState extends WalletState{

}

class  WalletErrorState extends WalletState{
  String mess;
  WalletErrorState(this.mess);
}

class  WalletSuccessState extends WalletState{
  String mess;
  WalletSuccessState(this.mess);


}