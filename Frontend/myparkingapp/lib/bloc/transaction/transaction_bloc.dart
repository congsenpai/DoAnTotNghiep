// ignore_for_file: non_constant_identifier_names


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/transaction/transaction_event.dart';
import 'package:myparkingapp/bloc/transaction/transaction_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/repository/transaction_repository.dart';

import 'package:myparkingapp/data/response/transaction_response.dart';

class TransactionBloc extends Bloc<TransactionEvent,TransactionState>{
  TransactionBloc(): super(TransactionInitialState()){
    on<LoadTransactionEvent> (_transactionByFilterScreen);
    on<LoadAllTransactionEvent >(_allTransactionScreen);
    on<LoadAllTransactionByTimeEvent>(_transactionByFilterDashboardScreen);
  }
  void _transactionByFilterScreen(LoadTransactionEvent event, Emitter<TransactionState> emit) async{
    try{
      emit(TransactionLoadingState());
      TransactionRepository tran_R = TransactionRepository();
      ApiResult tran = await tran_R.getTransactionByWalletDateTypePage(event.wallet,event.page, event.type, event.start, event.end );
      if(tran.code == 200){
        TransactionOnPage trans = tran.result;
        emit(TransactionLoadedState(trans.trans, event.start, event.end, event.type, trans.page, trans.pageTotal));
      }
      else{
        emit(TransactionErrorState(tran.message));
      }
    }
    catch(e){
      throw Exception("TransactionBloc__transactionScreen : $e");
      
    }
  }
  void _transactionByFilterDashboardScreen(LoadAllTransactionByTimeEvent event, Emitter<TransactionState> emit) async{
    try{
      emit(TransactionLoadingState());
      TransactionRepository tran_R = TransactionRepository();
      ApiResult tran = await tran_R.getTransactionByUserDateTypePage(event.userResponse.userID,event.type, event.start, event.end );
      if(tran.code == 200){
        TransactionOnPage trans = tran.result;
        emit(TransactionLoadedState(trans.trans, event.start, event.end, event.type, trans.page, trans.pageTotal));
      }
      else{
        emit(TransactionErrorState(tran.message));
      }
    }
    catch(e){
      throw Exception("TransactionBloc__transactionScreen : $e");
      
    }
  }
  void _allTransactionScreen(LoadAllTransactionEvent event, Emitter<TransactionState> emit) async{
    try{
      emit(TransactionLoadingState());
      TransactionRepository tran_R = TransactionRepository();
      ApiResult tran = await tran_R.getTransactionByWalletDateTypePage(event.wallet, event.page,null,null,null);
      if(tran.code == 200){
        TransactionOnPage trans = tran.result;
        DateTime start = DateTime(2020,12,20);
        DateTime end= DateTime.now();
        emit(TransactionLoadedState(trans.trans, start, end, null, trans.page, trans.pageTotal));
      }
      else{
        emit(TransactionErrorState(tran.message));
      }

      List<TransactionResponse> trans =  transactions;
        DateTime start = DateTime(2020,12,20);
        DateTime end= DateTime.now();
        emit(TransactionLoadedState(trans, start, end, Transactions.PAYMENT, event.page, 1));

    }
    catch(e){
      throw Exception("TransactionBloc__transactionScreen : $e");

    }
  }
}



