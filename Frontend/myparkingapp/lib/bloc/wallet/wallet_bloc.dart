import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/wallet/wallet_event.dart';
import 'package:myparkingapp/bloc/wallet/wallet_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/repository/wallet_repository.dart';
import 'package:myparkingapp/data/request/created_wallet_request.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';

class WalletBloc extends Bloc<WalletEvent,WalletState>{
  WalletBloc():super(WalletInitialState()){
    on<WalletInitialEvent>(_loadWalletScreen);
    on<AddWalletEvent>(_addWallet);
    on<LockWalletEvent>(_lockWallet);
  }


  void _loadWalletScreen( WalletInitialEvent event, Emitter<WalletState> emit) async{
    try{
      emit(WalletLoadingState());
      List<WalletResponse> wallets = walletdemo;
      emit(WalletLoadedState(wallets));
    }
    catch(e){
      throw Exception("WalletBloc : _loadWalletScreen : $e");
    }
  }
  void _addWallet(AddWalletEvent event, Emitter<WalletState> emit) async {
    try{
      emit(WalletLoadingState());
      WalletRepository wallet = WalletRepository();

      CreatedWalletRequest create = CreatedWalletRequest(balance: 0, currency: event.currency, name: event.name, userId: event.userId);
      ApiResult walletApi = await wallet.createWallet(create);
      if(walletApi.code == 200){
        
        emit(WalletSuccessState("Add successed"));
      }
      else{
        emit(WalletErrorState(walletApi.message));
      }
    }
    catch(e){
      throw Exception("WalletBloc : _addWallet : $e");
    }
  }
  void _lockWallet(LockWalletEvent event, Emitter<WalletState> emit) async {
    try{
      emit(WalletLoadingState());
      emit(WalletSuccessState("active"));
    }
    catch(e){
      throw Exception("WalletBloc : _lockWallet : $e");
    }
  }
}

