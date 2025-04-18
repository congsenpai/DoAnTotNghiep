// ignore_for_file: non_constant_identifier_names


import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/transaction/transaction_event.dart';
import 'package:myparkingapp/bloc/transaction/transaction_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/repository/transaction_repository.dart';

import 'package:myparkingapp/data/response/transaction_response.dart';

class TransactionBloc extends Bloc<TransactionEvent,TransactionState>{
  TransactionBloc(): super(TransactionInitialState()){
    on<LoadTransactionEvent> (_transactionByFilterScreen);
    on<LoadAllTransactionByTimeEvent>(_transactionByFilterDashboardScreen);
    on<FilterTransactionByTimeEvent>(_FilterDashboardScreen);
  }
  void _transactionByFilterScreen(LoadTransactionEvent event, Emitter<TransactionState> emit) async{
    try{
      emit(TransactionLoadingState());
      TransactionRepository tran_R = TransactionRepository();
      ApiResult tran = await tran_R.getTransactionByWalletDateTypePage(event.wallet,event.page, event.type,event.size);
      if(tran.code == 200){
        TransactionOnPage trans = tran.result;
        emit(TransactionLoadedState(trans.trans, event.type, trans.page, trans.pageTotal, event.size));
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
      ApiResult tran = await tran_R.getTransactionByUserDateTypePage(event.userResponse.userID,event.size );
      if(tran.code == 200){
        List<TransactionResponse> trans = tran.result;
        emit(TransactionDashboardLoadedState(trans,event.size));
      }
      else{
        emit(TransactionErrorState(tran.message));
      }
    }
    catch(e){
      throw Exception("TransactionBloc__transactionScreen : $e");
      
    }
  }

  void _FilterDashboardScreen(FilterTransactionByTimeEvent event, Emitter<TransactionState> emit) async{
    try{
      emit(TransactionLoadingState());
      List<TransactionResponse> trans = event.tran;
      if(event.type !=null){
        trans = trans.where((e)=>e.type == event.type!).toList();
      }
      if(event.start != null && event.end !=null){
        trans = trans.where((e)=>e.createAt.isBefore(event.end!) && e.createAt.isAfter(event.start!)).toList();
      }
      emit(TransactionDashboardLoadedState(trans,event.size));

    }
    catch(e){
      throw Exception("TransactionBloc__transactionScreen : $e");

    }
  }
}



