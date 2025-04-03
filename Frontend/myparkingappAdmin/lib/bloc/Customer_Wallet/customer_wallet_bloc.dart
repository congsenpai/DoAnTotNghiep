import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/apiResponse.dart';
import 'package:myparkingappadmin/bloc/Customer_Wallet/customer_wallet_state.dart';
import 'package:myparkingappadmin/bloc/customer_wallet/customer_wallet_event.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/repository/userRepository.dart';

class  CustomerWalletBloc extends Bloc< CustomerWalletEvent, CustomerWalletState>{
   CustomerWalletBloc():super(CustomerWalletInitial()){
    on<CWLoadingScreenEvent>(_giveOwnerList);
   }
   void _giveOwnerList(CWLoadingScreenEvent event, Emitter<CustomerWalletState> emit) async {
    UserRepository userRepository = UserRepository();
    try {
      APIResult userResult = await userRepository.giveAllUserByPage_BySearch_ByOWNER_ROLE(0,event.token,'ROLE_OWNER',event.search);
      List<UserResponse> customer = [];
      customer=userResult.result;
      String message = userResult.message;
      int code = userResult.code;
      if(code == 200){
        emit(CustomerWalletLoadedState(customer,event.page, userResult.pageAmount,)); // Ensure a value is returned
      }
      else{
        emit(CustomerWalletErrorState(message));
      }
    } catch (e) {
      emit(CustomerWalletErrorState("Cannot give owner list")); // Ensure an exception is thrown
    }
  }

  void _LockOwnerList(){

  }







}