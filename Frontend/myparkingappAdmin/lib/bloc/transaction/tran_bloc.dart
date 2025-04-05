import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/transaction/tran_event.dart';
import 'package:myparkingappadmin/bloc/transaction/tran_state.dart';
import 'package:myparkingappadmin/repository/transactionRepository.dart';


class  TransactionBloc extends Bloc< TransactionEvent, TransactionState>{
   TransactionBloc():super(TransactionInitial()){
    on<GetTransactionsByWalletEvent>(_getTransactionsByWallet);
   }
   void _getTransactionsByWallet(GetTransactionsByWalletEvent event, Emitter<TransactionState> emit) async{
     try{
       emit(TransactionLoadingState());
       TransactionRepository transactionRepository = TransactionRepository();
       // Call the repository method to get parking slots by lot
       final response = await transactionRepository.getTransactionsByWallet(event.parkingLotID);
       if(response.code == 200){
         emit(TransactionLoadedState(response.result));
       }else{
         emit(TransactionErrorState(response.message));
       }
     }catch(e){
       emit(TransactionErrorState("Error: $e"));
     }
   }
}