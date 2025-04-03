

import 'package:myparkingappadmin/data/dto/response/user_response.dart';

abstract class  CustomerWalletState{}

class  CustomerWalletInitial extends CustomerWalletState{

}

class  CustomerWalletLoadingState extends CustomerWalletState{

}

class  CustomerWalletLoadedState extends CustomerWalletState{
  int page;
  int pageTotal;
  List<UserResponse> user;
  CustomerWalletLoadedState(this.user, this.page, this.pageTotal);
}

class  CustomerWalletErrorState extends CustomerWalletState{
  String mess;
  CustomerWalletErrorState(this.mess);
}

class  CustomerWalletSuccessState extends CustomerWalletState{
  String mess;
  CustomerWalletSuccessState(this.mess);


}