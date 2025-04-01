import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/transaction/event.dart';
import 'package:myparkingappadmin/bloc/transaction/state.dart';


class  TransactionBloc extends Bloc< TransactionEvent, TransactionState>{
   TransactionBloc():super(TransactionInitial()){
    
   }
}